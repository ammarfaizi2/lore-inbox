Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269395AbRHGUD3>; Tue, 7 Aug 2001 16:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269393AbRHGUDU>; Tue, 7 Aug 2001 16:03:20 -0400
Received: from [208.134.143.150] ([208.134.143.150]:56969 "EHLO
	mail.playnet.com") by vger.kernel.org with ESMTP id <S269392AbRHGUDE>;
	Tue, 7 Aug 2001 16:03:04 -0400
Message-ID: <031901c11f7c$2185b0e0$0b32a8c0@playnet.com>
From: "Marty Poulin" <mpoulin@playnet.com>
To: "Dan Podeanu" <pdan@spiral.extreme.ro>,
        "Torrey Hoffman" <torrey.hoffman@myrio.com>
Cc: "'David Maynor'" <david.maynor@oit.gatech.edu>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0108072212590.18776-100000@spiral.extreme.ro>
Subject: Re: encrypted swap
Date: Tue, 7 Aug 2001 15:04:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dan Podeanu" <pdan@spiral.extreme.ro>
> /proc/kcore & the likes). If its going to be stolen while its offline, you
> can have your shutdown scripts blank the swap partition and the boot
> scripts call mkswap on it.

Assuming that the notebook was shutdown correctly is a big assumption.  The
notebook could run out of power or freeze-up and if the user is not able to
immediately able to restart the computer the swap is all laid out with a
ribbon.

No I have to agree that a more elegant solution to this is encrypt
everything and require the user to input the password whenever the system
boots or returns from suspend.

Marty Poulin
vandal@playnet.com
Lead Programmer
Host/Client Communications
Playnet Inc./Cornered Rat Software

