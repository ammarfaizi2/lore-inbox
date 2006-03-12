Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWCLUxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWCLUxe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 15:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWCLUxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 15:53:33 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61674 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932193AbWCLUxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 15:53:33 -0500
Date: Sun, 12 Mar 2006 21:53:30 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Patrick Mau <mau@oscar.ping.de>
cc: Eric.Brunet@lps.ens.fr,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problem with a CD
In-Reply-To: <20060312181548.GA14889@oscar.prima.de>
Message-ID: <Pine.LNX.4.61.0603122152350.3155@yvahk01.tjqt.qr>
References: <20060312162825.GA16993@platane.lps.ens.fr>
 <20060312181548.GA14889@oscar.prima.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sun, Mar 12, 2006 at 05:28:25PM +0100, Eric.Brunet@lps.ens.fr wrote:
>>>In short: I have a CD that windows XP can read but that linux cannot.
>>>What could be the problem ?
>
>Since this is a video cd, the files associated with the stream cannot
>be accessed by mounting the medium.

It's because the video data is outside the iso9660 fs, is not it?

>The filesystem of VCD is not a
>normal filesystem, so you have to rip the video stream by using a tool
>like vcdxrip.


Jan Engelhardt
-- 
