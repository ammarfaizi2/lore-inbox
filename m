Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbSI2H4G>; Sun, 29 Sep 2002 03:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262411AbSI2H4G>; Sun, 29 Sep 2002 03:56:06 -0400
Received: from 62-190-216-37.pdu.pipex.net ([62.190.216.37]:30724 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262410AbSI2H4G>; Sun, 29 Sep 2002 03:56:06 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209290716.g8T7GNwf000562@darkstar.example.net>
Subject: Re: v2.6 vs v3.0
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 29 Sep 2002 08:16:23 +0100 (BST)
Cc: jdickens@ameritech.net, torvalds@transmeta.com, mingo@elte.hu,
       jgarzik@pobox.com, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, saw@saw.sw.com.sg, rusty@rustcorp.com.au,
       richardj_moore@uk.ibm.com, andre@master.linux-ide.org
In-Reply-To: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> from "Linus Torvalds" at Sep 28, 2002 06:31:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The block IO cleanups are important, and that was the major thing _I_ 
> personally wanted from the 2.5.x tree when it was opened. I agree with you 
> there. But I don't think they are major-number-material.

I'd definitely have voted for stable IPV6 being a 3.0.x requirement, but I guess it's a bit late now :-/

> Anyway, people who are having VM trouble with the current 2.5.x series, 
> please _complain_, and tell what your workload is. Don't sit silent and 
> make us think we're good to go.. And if Ingo is right, I'll do the 3.0.x 
> thing.

I think the broken IDE in 2.5.x has meant that it got seriously less testing overall than previous development trees :-(.  Maybe after halloween when it stabilises a bit more we'll get more reports in.

John
