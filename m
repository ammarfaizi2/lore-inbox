Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289106AbSA3LRF>; Wed, 30 Jan 2002 06:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289108AbSA3LQz>; Wed, 30 Jan 2002 06:16:55 -0500
Received: from aboukir-101-2-1-easter.adsl.nerim.net ([62.4.19.191]:23170 "HELO
	verveine") by vger.kernel.org with SMTP id <S289106AbSA3LQt>;
	Wed, 30 Jan 2002 06:16:49 -0500
Date: Wed, 30 Jan 2002 12:16:40 +0100
From: "'Brugier Pascal'" <pbrugier@easter-eggs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 cpqarray eepro100 ext3
Message-ID: <20020130121640.A3571@easter-eggs.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020122145844.A622@easter-eggs.com> <000b01c1a34f$65e6e860$2a0110ac@netlinkaccess.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <000b01c1a34f$65e6e860$2a0110ac@netlinkaccess.com>; from akropel1@rochester.rr.com on Tue, Jan 22, 2002 at 09:16:34AM -0500
X-Operating-System: Debian Gnu/Linux 2.4.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 09:16:34AM -0500, Adam Kropelin wrote:
> Brugier Pascal:
> > Hi
> > 
> > I'm not on the mailling list can you CC'ed the answers/comments
> > posted to the list in response to my posting? thank you.
> > 
> > I have a Compaq Prolient DL 360, 1 PIII 1 GHz, 2 scsi hd in Raid 1
> > 2 ethernet controlers eepro100 (only one is used) and ext3 fs.
> 
> <snip>
> 
> > Invalid operand 00000 (i'm not sur about thenumber of 0 because
> > someone else read for me and doesn't remember)
> 
> <snip>
> 
> Pascal,
> 
> I had this same problem on my home-grown server (i.e., not a Compaq)
> running a Compaq Smart 221. It followed me across kernel versions and
> across cpqarray driver versions. In my case it turned out to be bad RAM
> in the server uncovered by memtest86. With new RAM it's now rock-solid
> for me.
> 
> There is an updated version of cpqarray in 2.4.13-ac7 (not sure which
> -ac it came in at, but that's the one I grabbed it from) which you can
> copy directly into 2.4.17 if you want. I see slightly improved
> performance with that update, though it was the RAM that actually solved
> my issue. 
> 

Hi 

I'm sur now that it's not a memory problem, i downgrad to 2.4.13
and everything work fine.

I'll send a new mail with more explications to the list (now i'd
suscribe), to explain my problem and what i found (with from others 
of course).

Best regards

-- 
Pascal Brugier
---------------------------------------------------------------
Easter-eggs                               Spécialiste GNU/Linux
44-46 rue de l'Ouest  -  75014 Paris  -  France  -  Métro Gaité
Phone: +33 (0) 1 43 35 00 37    -    Fax: +33 (0) 1 43 35 00 76
mailto:pbrugier@easter-eggs.com  -   http://www.easter-eggs.com
---------------------------------------------------------------
709D77A2 -   ED24 4E29 E5B4 FDE7 56A4  352D F24E 7E68 709D 77A2
_______________________________________________________________
