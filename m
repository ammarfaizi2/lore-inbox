Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbSJOB4H>; Mon, 14 Oct 2002 21:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbSJOB4H>; Mon, 14 Oct 2002 21:56:07 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:63647 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262272AbSJOB4H>;
	Mon, 14 Oct 2002 21:56:07 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200210150157.FAA13254@sex.inr.ac.ru>
Subject: Re: [RFC] Rename _bh to _softirq
To: mingo@elte.hu
Date: Tue, 15 Oct 2002 05:57:52 +0400 (MSD)
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210142119300.26635-100000@localhost.localdomain> from "Ingo Molnar" at Oct 14, 2 09:21:23 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>         But yes, i agree, and there are a number of other
> renames that would make perfect sense.

Oh, do you dislike names with history? I love them. :-)
Well, bh is short, looks nice and cryptic enough.

After true BHs have gone, just say that "bh" is alias for "softirq".

Alexey
