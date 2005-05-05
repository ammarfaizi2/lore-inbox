Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVEENP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVEENP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 09:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVEENP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 09:15:58 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:35488 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262102AbVEENPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 09:15:38 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-os@analogic.com, Daniel Jacobowitz <dan@debian.org>
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
Date: Thu, 5 May 2005 16:14:55 +0300
User-Agent: KMail/1.5.4
Cc: Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>
References: <4279084C.9030908@free.fr> <Pine.LNX.4.61.0505042031120.22323@chaos.analogic.com> <Pine.LNX.4.61.0505050814340.24130@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0505050814340.24130@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505051614.55899.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 May 2005 15:24, Richard B. Johnson wrote:
> 
> I don't think the kernel handler gets a chance to do anything
> because SYS-V init installs its own handler(s). There are comments
> about Linux misbehavior in the code. It turns out that I was
> right about SIGSTOP and SIGCONT...

No you are not.
--
vda

