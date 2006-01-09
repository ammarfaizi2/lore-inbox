Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWAIPXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWAIPXO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWAIPXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:23:14 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:46241 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932370AbWAIPXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:23:13 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Mon, 9 Jan 2006 17:22:59 +0200
User-Agent: KMail/1.8.2
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
References: <174467f50601082354y7ca871c7k@mail.gmail.com> <200601091022.30758.s0348365@sms.ed.ac.uk> <200601091403.46304.yarick@it-territory.ru>
In-Reply-To: <200601091403.46304.yarick@it-territory.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091723.00093.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 January 2006 13:03, Yaroslav Rastrigin wrote:
> Hi, 
> > > > money to the right people.
> > >
> > > Could or would you be so kind to provide at least moderately complete
> > > pricelist ? Whom and how much should I pay to have correct support for
> > > intel graphics chipset, 2200BG Wi-Fi, complete
> > > suspend-to-disk/suspend-to-ram and to get an overall performance boost ?
> > 
> > Since these are all supported in 2.6.15, $0 would be my quote.
>
> I've mentioned _correct_ support. Contrary to current rather sad state of things. 
> 855GM still has no support for non-VESA videomodes (1280x800 can be enabled
> only via VBIOS hacks, and is not always properly restored on resume)  
> (and don't supported with intelfb) (which, AFAIK, has no support for dualhead)
> 2200BG sometimes starts to unacceptably lag and drop packets after going out
> of suspend (either STR or STD) and until reboot. 
> (And this is driver issue)

> Suspend to ram works, more or less, but drains power like hungry cat drinks milk,
> and I just can't leave my laptop in STR for more than two days  
> without worrying about my on-the-road availability. 
> Suspend to disk has nasty tendency to ruin my whole hot live X session,
> since X can't properly restore VT on resume. 

> Overall performance isn't that bad, either, but I just can't understand,
> why KATE (Kde more or less advanced editor) takes twice as long to start  
> as UltraEdit in _emulated_ (VMWare) Windows XP running on this same box.

stracing kate with -t, -tt, -ttt and/or -T options may help. man strace.
(Do you have such tool in Windows?)
 
> So, the question remains the same - whom and how much I need to pay
> to solve abovementioned problems? 

Maybe RedHat, or Suse, or some other commercial distro.
--
vda
