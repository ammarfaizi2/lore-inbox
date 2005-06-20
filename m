Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVFTUMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVFTUMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVFTULH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:11:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48339 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261494AbVFTUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:10:25 -0400
Date: Mon, 20 Jun 2005 18:57:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: IBM HDAPS Someone interested?
Message-ID: <20050620165703.GB477@openzaurus.ucw.cz>
References: <20050620155720.GA22535@ucw.cz> <005401c575b3_5f5bba90_600cc60a@amer.sykes.com> <20050620163456.GA24111@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620163456.GA24111@ucw.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't think they have anything in the BIOS related to the HDAPS, else they
> > would have put something in it. (You can't even disable the chip in the
> > BIOS) I just think is the accelerometer, there, by itself with an extra card
> > they added.
>  
> Well, some piece of software needs to park the HDD when the notebook is
> falling, and that piece of software should better be running since the
> notebook is powered on. Hence my suspicion it's in the BIOS. It doesn't
> have to be visible to the user, at all.

Actually yes, it needs to be visible to the user and no, it probably should not run during boot.
If user is in plane/train, accellerometers will basically detect problems all the time;
still you want to use the computer.
(And you still want the machine to boot => default == fall detection off).

IIRC there's windows program to control it.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

