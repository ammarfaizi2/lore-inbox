Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbSJMPTd>; Sun, 13 Oct 2002 11:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbSJMPTd>; Sun, 13 Oct 2002 11:19:33 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:18158 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261532AbSJMPTc>; Sun, 13 Oct 2002 11:19:32 -0400
Message-ID: <20021013152510.13283.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 13 Oct 2002 23:25:10 +0800
Subject: Re:Benchmark results from resp1 trivial response time test
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Davidsen <davidsen@tmr.com>
> On Sun, 13 Oct 2002, Paolo Ciarrocchi wrote:
> 
> > Hi David,
>   thanks for the quick results, but it's Bill...
Ops... sorry ;-)
 
> > I think your benchmark is very intersting.
> > Here goes my results:
> 
> > It seems that 2.5.42-mm2 is the "winner".
> 
> > Comments ?
> 
> This mirrors my results, which is encouraging. The -mm2 patch seems to
> improve performance under write pressure quite a bit. I am attaching Con
> Kolivas' patch to 41-mm2 in case you missed it, as you can note from the
> results on the website, it improves things beyond -mm2. If you decide to
> run this version I'd like to see the result. I believe I had to use the
> "-l" patch option to ignore blank mismatches to get this to work, and I've
> cleaned up another mailing funny as well. 

Ok, thanks for the patch. 
I try it and I back with the result.

Ciao,
         Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
