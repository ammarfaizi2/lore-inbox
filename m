Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWETHNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWETHNj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 03:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWETHNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 03:13:39 -0400
Received: from rrcs-24-227-114-150.se.biz.rr.com ([24.227.114.150]:4002 "EHLO
	sleekfreak.ath.cx") by vger.kernel.org with ESMTP id S1751263AbWETHNj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 03:13:39 -0400
Date: Sat, 20 May 2006 03:14:04 -0400 (EDT)
From: shogunx <shogunx@sleekfreak.ath.cx>
To: Bart Samwel <bart@samwel.tk>
cc: David Lang <dlang@digitalinsight.com>,
       =?ISO-8859-1?Q?=22D=F6hr=2C_Markus_ICC-H=22?= 
	<Markus.Doehr@siegenia-aubi.com>,
       "'Peter Gordon'" <codergeek42@gmail.com>, <Valdis.Kletnieks@vt.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: replacing X Window System !
In-Reply-To: <446EBDB3.2050401@samwel.tk>
Message-ID: <Pine.LNX.4.44.0605200313470.28363-100000@sleekfreak.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2006, Bart Samwel wrote:

> David Lang wrote:
> > On Sat, 20 May 2006, "Döhr, Markus ICC-H" wrote:
> >
> >> Date: Sat, 20 May 2006 02:57:55 +0200
> >> From: "\"Döhr, Markus ICC-H\"" <Markus.Doehr@siegenia-aubi.com>
> >> Did you actually do that? Starting Firefox over a 6 Mbit VPN takes
> >> about 3
> >> minutes on a FAST machine. That´s not acceptable - our users want
> >> (almost)
> >> immediate response to an application, to clicking and waiting 10 seconds
> >> until the app is doing something.
> >
> > this is due to the latency, not the speed (X by default requires many
> > round-trips to startup). There is an extention that greatly reduces the
> > number of round-trips nessasary, I'm willing to bet this will make a
> > huge difference for your startup. Unfortunantly I don't remember what
> > this is.
>
> I think it's called "lbxproxy".

Description: Low Bandwidth X (LBX) proxy server
 Applications that would like to take advantage of the Low Bandwidth
extension
 to X (LBX) must make their connections to an lbxproxy.  These
applications
 need know nothing about LBX, they simply connect to the lbxproxy as if
were a
 regular X server.  The lbxproxy accepts client connections, multiplexes
them
 over a single connection to the X server, and performs various
optimizations
 on the X protocol to make it faster over low bandwidth and/or high
latency
 connections.





>
> Cheers,
> Bart
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

sleekfreak pirate broadcast
http://sleekfreak.ath.cx:81/

