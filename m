Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318877AbSHTOH1>; Tue, 20 Aug 2002 10:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318862AbSHTOH1>; Tue, 20 Aug 2002 10:07:27 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:19388 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S318877AbSHTOH1>;
	Tue, 20 Aug 2002 10:07:27 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208201410.SAA12318@sex.inr.ac.ru>
Subject: Re: igmp kernel issues.
To: tom@rooted.NET (Tom Parker)
Date: Tue, 20 Aug 2002 18:10:40 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.2.0.58.20020820135148.02f70ed8@193.133.49.25> from "Tom Parker" at Aug 20, 2 05:45:05 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Currently the kernel dosnt seem to pass IGMP reports to user space
> unless there is a route

Do you have rp filter enabled? Disable.

Alexey
