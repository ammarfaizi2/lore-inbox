Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290062AbSA3Qkv>; Wed, 30 Jan 2002 11:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290045AbSA3Qjp>; Wed, 30 Jan 2002 11:39:45 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:8642 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290062AbSA3QjQ>; Wed, 30 Jan 2002 11:39:16 -0500
Date: Wed, 30 Jan 2002 18:34:12 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michel Angelo da Silva Pereira <michelpereira@uol.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 2.4.18-pre3-ac2 with Intel ServerRAID Controller
In-Reply-To: <E16Vxug-0007lP-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0201301832360.5518-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Alan Cox wrote:

> The adaptec driver won't touch the IBM ServeRAID - that side is ok. The
> generic i2o will see it as it claims to be an I2O device but the right
> driver is the IBM ips driver

Hmmm i guessed IBM ServeRAID, but then wasn't 100% sure. Thats 
interesting, because in order to get my IBM ServeRAID 4L card to work 
under 2.2.18 i had to use both the ips driver _and_ generic i2o code too.

Thanks,
	Zwane Mwaikambo


