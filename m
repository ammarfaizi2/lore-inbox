Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132370AbRDUAgl>; Fri, 20 Apr 2001 20:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132372AbRDUAgb>; Fri, 20 Apr 2001 20:36:31 -0400
Received: from ns.suse.de ([213.95.15.193]:57348 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132370AbRDUAgW>;
	Fri, 20 Apr 2001 20:36:22 -0400
Date: Sat, 21 Apr 2001 02:34:29 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 'make dep' warning with 2.4.3 : computed checksums did NOT match
Message-ID: <20010421023429.A19047@pingi.muc.suse.de>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3AE0D3DC.5050009@eisenstein.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3AE0D3DC.5050009@eisenstein.dk>; from juhl@eisenstein.dk on Sat, Apr 21, 2001 at 02:27:08AM +0200
Organization: SuSE Muenchen GmbH
X-Operating-System: Linux 2.2.18-SMP i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 02:27:08AM +0200, Jesper Juhl wrote:
> Hi,
> 
> While compiling a 2.4.3 kernel on my Slackware 7.1 box (heavily updated 
> to have the correct utils and so on) I noticed a warning during 'make dep'.
> 
> This is the exact message:
> 
> make[6]: Leaving directory /usr/src/linux-2.4.3/drivers/isdn/eicon'
> make -C hisax fastdep
> md5sum: WARNING: 12 of 12 computed checksums did NOT match
> make[6]: Entering directory /usr/src/linux-2.4.3/drivers/isdn/hisax'
> 
> I'm not using any of the isdn stuff, so I'm not really worried about 
> this, but I thought I'd report it anyway since 'someone more 
> knowledgeable than me (TM)' might find it important...

Not a real problem (only cosmetics) and a patch is pending.

-- 
Karsten Keil
SuSE Labs
ISDN development
