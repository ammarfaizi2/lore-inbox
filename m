Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281806AbRK0W5o>; Tue, 27 Nov 2001 17:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281807AbRK0W5e>; Tue, 27 Nov 2001 17:57:34 -0500
Received: from mail016.mail.bellsouth.net ([205.152.58.36]:52056 "EHLO
	imf16bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281806AbRK0W5V>; Tue, 27 Nov 2001 17:57:21 -0500
Message-ID: <3C041A4B.454E18E1@mandrakesoft.com>
Date: Tue, 27 Nov 2001 17:57:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: onboard ethernet/sound on Soyo SY-K7V?
In-Reply-To: <Pine.LNX.4.33.0111271514320.28301-100000@mooru.gurulabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson wrote:
> 
> I'm looking a purchasing a dozen computers with the Soyo SY-K7V Dragon
> Plus motherboard.  It has the KT266A chipset.
> 
> My question is Linux support for the onboard ethernet and sound.  I've
> googled all over and haven't come up with a definitive answer.
> 
> They are described as "VIA 10/100 Ethernet" and "CMI 8738 Audio chip".

what does 'lspci -vn' show for your system?

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

