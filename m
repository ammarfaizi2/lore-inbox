Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265159AbUADKMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 05:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265272AbUADKMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 05:12:06 -0500
Received: from mail.mediaways.net ([193.189.224.113]:5270 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S265159AbUADKME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 05:12:04 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Soeren Sonnenburg <kernel@nn7.de>
To: Lincoln Dale <ltd@cisco.com>
Cc: Con Kolivas <kernel@kolivas.org>, Willy Tarreau <willy@w.ods.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
In-Reply-To: <5.1.0.14.2.20040104195316.02151e98@171.71.163.14>
References: <200401041242.47410.kernel@kolivas.org>
	 <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
	 <200401040815.54655.kernel@kolivas.org>
	 <20040103233518.GE3728@alpha.home.local>
	 <200401041242.47410.kernel@kolivas.org>
	 <5.1.0.14.2.20040104195316.02151e98@171.71.163.14>
Content-Type: text/plain
Message-Id: <1073211091.3261.4.camel@localhost>
Mime-Version: 1.0
Date: Sun, 04 Jan 2004 11:11:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-04 at 09:54, Lincoln Dale wrote:
> At 07:09 PM 4/01/2004, Soeren Sonnenburg wrote:
> [..]
> >Looking at that how can it not be a scheduling problem ....
> 
> out of interest, have you tried to see how 2.4.xx compares when compiled 
> with HZ set to 1000?
> (or conversely, 2.6 compiled with HZ set to 100)

assuming you mean changing the HZ value in include/param.h to 1000/100
yes 2.4 with HZ=1000 is fine and 2.6 with HZ=100 still #%$@$^&!!

Soeren

