Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLDKEz>; Mon, 4 Dec 2000 05:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLDKEg>; Mon, 4 Dec 2000 05:04:36 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3076 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129387AbQLDKE3>;
	Mon, 4 Dec 2000 05:04:29 -0500
Message-ID: <20001202225909.B6988@bug.ucw.cz>
Date: Sat, 2 Dec 2000 22:59:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick van de Lageweg <patrick@bitwizard.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [PATCH] New user space serial port driver
In-Reply-To: <Pine.LNX.4.21.0011300903470.11226-100000@panoramix.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0011300903470.11226-100000@panoramix.bitwizard.nl>; from Patrick van de Lageweg on Thu, Nov 30, 2000 at 09:04:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Please consider including this user space serial driver. It was writen for
> the Pele 833 RAS Server but is also usable for other serial device drivers
> in user space.

Good, someone finally implemented this. This is going to be mandatory
if we want to support winmodems properly; also ISDN people might be
interested [to kick AT emulation out of kernel].
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
