Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318161AbSIJVvu>; Tue, 10 Sep 2002 17:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSIJVvu>; Tue, 10 Sep 2002 17:51:50 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:16290 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S318161AbSIJVvt>; Tue, 10 Sep 2002 17:51:49 -0400
Message-ID: <20020910215458.20093.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 11 Sep 2002 05:54:58 +0800
Subject: Re: [patch] Re: 2.5.3[3,4] Preemption problem
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Love <rml@tech9.net>
> On Mon, 2002-09-09 at 17:31, Paolo Ciarrocchi wrote:
> 
> > Halting system...
> > Shutting down devices
> > Power down.
> > note: halt[15347] exited with preempt_count 1
> 
> I cooked up a patch... does this solve the problem (no more spurious
> warning on reboot)?
Yes it does.
Thank you.

Ciao,
           Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
