Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSJ2W7U>; Tue, 29 Oct 2002 17:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbSJ2W7T>; Tue, 29 Oct 2002 17:59:19 -0500
Received: from 205-158-62-44.outblaze.com ([205.158.62.44]:36808 "EHLO
	mta1-3.us4.outblaze.com") by vger.kernel.org with ESMTP
	id <S262449AbSJ2W7T>; Tue, 29 Oct 2002 17:59:19 -0500
Message-ID: <20021029223856.21280.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Date: Wed, 30 Oct 2002 06:38:56 +0800
Subject: Re: poll-related "scheduling while atomic", 2.5.44-mm6
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So my guess is somewhere between -mm5 and -mm6 we
>> screwed up the atomicity count.
>Mine too.  I'll check it out, thanks.

The same here as well

>Do you have preemption enabled?

yes

Paolo
-- 

Powered by Outblaze
