Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133106AbRECRDR>; Thu, 3 May 2001 13:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133098AbRECRDH>; Thu, 3 May 2001 13:03:07 -0400
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:48858 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S133113AbRECRDA>; Thu, 3 May 2001 13:03:00 -0400
Message-ID: <3AF18F40.BD741542@ukgateway.net>
Date: Thu, 03 May 2001 18:02:56 +0100
From: Andy Piper <squiggle@ukgateway.net>
Reply-To: andy.piper@freeuk.com
Organization: excalibur
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Dane-Elec PhotoMate Combo
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(NB I'm not a subscriber to linux-kernel, I picked up this thread from
one of the NNTP gateways; please cc me on any replies. Thanks)

I've recently purchased one of these to use with the SmartMedia cards
from my Fuji FinePix 4700 (yes, I know the camera is already supported
as a USB mass storage device). Searching for information on using it
with Linux pointed me to this thread.

I've been unable to get the card reader to work - i.e. get the card
mounted - using the 2.4.2-2 kernel which came with RedHat 7.1,
although the device itself appears to be recognised (according to
/proc/bus/usb/devices). I've also tried 2.4.4, but had even less
success.

The discussion here between Matt Dharm and Andries Brouwer seems to
revolve around the fact that the patch Andries has proposed is
"risky". Clearly I don't have Matt's level of knowledge in this area,
so I'm following his advice for the moment.

I'd quite like to get the device working and stable, and so would
Andries and at least one other person who has posted to the list of
supported USB devices hosted at http://www.qbik.ch/usb/devices/ ... so
the question is simple: what can we do to help? I've not currently got
any experience contributing to the kernel, and I have next-to-no
knowledge of USB, but I'm prepared to put some effort in here.

Andy

-- 
Andy Piper - Fareham, Hampshire (UK)
andy.piper@freeuk.com - ICQ #86489434
http://www.andyp.uklinux.net
