Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbRESUaD>; Sat, 19 May 2001 16:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbRESU3x>; Sat, 19 May 2001 16:29:53 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26283 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261277AbRESU3s>;
	Sat, 19 May 2001 16:29:48 -0400
Message-ID: <3B06D7B1.DD5C6DF9@mandrakesoft.com>
Date: Sat, 19 May 2001 16:29:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Cavan <johnc@damncats.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Potential help for VIA problems and ASUS motherboards
In-Reply-To: <3B06B453.6C921457@damncats.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cavan wrote:
> 
> Hi,
> 
> I've seen a lot of messages regarding problems with the VIA chipset...
> I've experienced them myself.
> 
> Anyways, I just put in a new ASUS CUV4X-D motherboard, BIOS revision
> 1004. Once installed, I ran into a raft of problems when IO-APIC was
> enabled... and discovered that ASUS had a BIOS update (revision 1007)
> available. Once the BIOS was updated and MPS 1.4 support was disabled,
> everything has been working fine, including USB with IO-APIC enabled. I
> also don't seem to be getting the timer problem anymore.
> 
> Anyways, if you have one of these boards, you may want to flash your
> BIOS and see if the problems are fixed. YMMV, but it worked for me.

I'm curious if 2.4.5-pre3 works for you... when using MPS 1.4, or,
without the BIOS update.

Regards,

	Jeff


-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
