Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSFJAmS>; Sun, 9 Jun 2002 20:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315754AbSFJAmR>; Sun, 9 Jun 2002 20:42:17 -0400
Received: from pcp947161pcs.cstltn01.in.comcast.net ([68.58.145.243]:51212
	"EHLO mail.trelane.net") by vger.kernel.org with ESMTP
	id <S315456AbSFJAmQ>; Sun, 9 Jun 2002 20:42:16 -0400
Date: Sun, 9 Jun 2002 19:42:15 -0500
From: Andrew D Kirch <trelane@trelane.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Promise driver (pdc202xx)]
Message-Id: <20020609194215.7c8dc7ea.trelane@trelane.net>
In-Reply-To: <1023666681.1163.4.camel@vaarlahti>
Organization: Trelane Networking Services
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try using hdparm to fix this, some distributions do a better
job than others setting up hardware, and udma6 being so new
it's not unlikely that your dist simply can't take this into 
account.  I use an asusa7v266-e and have had no harddrive controller
issues in ata-100, grab the latest hdparm, and the latest kernel (ensuring
it supports udma mode 6, and compile both.


On 10 Jun 2002 02:51:20 +0300
Jussi Laako <jussi.laako@kolumbus.fi> wrote:

> I'm forwarding my mail to lkml also.
> 
> As addition to the information, mobo is ASUS A7M266 and Promise BIOS
> version is 2.20.0.12.
> 
> 
> 	- Jussi Laako
> 
> -- 
> PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
> GPG key fingerprint: 0D10 D6D5 9F14 1A88 BA7F  7F17 ED92 8E98 EB43 8990
> Available at PGP keyservers
> 


-- 
Andrew D Kirch
Administrator, Dungeonfyre IRC Network
Catalyst OpenProjects IRC Network
Staff Dungeonfyre Shellhosting
