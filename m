Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbSJNHc5>; Mon, 14 Oct 2002 03:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSJNHc5>; Mon, 14 Oct 2002 03:32:57 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:31898 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261863AbSJNHcy>; Mon, 14 Oct 2002 03:32:54 -0400
Message-ID: <20021014073837.21244.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Date: Mon, 14 Oct 2002 15:38:37 +0800
Subject: Re:Benchmark results from resp1 trivial response time test
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Davidsen <davidsen@tmr.com>
[...]
> > Do you think is it possible to apply the patch on the top of 2.5.42-mm2 ?
> 
> I haven't tried it yet, but I'm interested in your result, since my
> 2.5.41-mm2v result was actually better then plain -mm2. I am just building
> some new test stuff on an SMP machine so I can compare uni and SMP
> performance under load, and I'll look at 2.5.42 tonight or tomorrow.
Well, I did't run the test against 2.5.41-mm2, I'll do it just to compare the result with 2.5.42-mm2+vmscan patch.


> My reference machine was a 96MB machine, if you're really curious about
> this you could boot with mem=96m (or 128m) and rerun the test. In any case
> I have the kids tonight, if I get some time I'll try it, otherwise
> tomorrow.
Ok, I'll try to find the time to run the test against 2.5.42 and 96 or 128MiB of Ram. 

          Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
