Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129498AbRB0UGm>; Tue, 27 Feb 2001 15:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbRB0UGc>; Tue, 27 Feb 2001 15:06:32 -0500
Received: from www.topmail.de ([212.255.16.226]:43918 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S129498AbRB0UGQ> convert rfc822-to-8bit;
	Tue, 27 Feb 2001 15:06:16 -0500
Message-ID: <036601c0a0f8$bd0ad070$742c9c3e@tp.net>
From: "Thorsten Glaser Geuer" <eccesys@topmail.de>
To: <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <F281raFC8XymNMDdckH00012e6f@hotmail.com> <000001c0a0ed$1ea188d0$742c9c3e@tp.net> <97h0bq$kdc$1@cesium.transmeta.com>
Subject: Re: ISO-8859-1 completeness of kernel fonts?
Date: Tue, 27 Feb 2001 20:05:53 -0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "H. Peter Anvin" <hpa@zytor.com>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, February 27, 2001 7:49 PM
Subject: Re: ISO-8859-1 completeness of kernel fonts?


> Followup to:  <000001c0a0ed$1ea188d0$742c9c3e@tp.net>
> By author:    "Thorsten Glaser Geuer" <eccesys@topmail.de>
> In newsgroup: linux.dev.kernel
> > 
> > My second suggestion: code it as .psfu and load it by setfont, including
> > the appropiate console-map. AFAIK all the kernel default fonts are cp437
> > (linux/drivers/char/cp437.uni; consolemap.*)
> > 
> 
> Something that would be really good is if someone could contribute PSF
> (v1 and v2) support for gfe <http://www.gnu.org/software/gfe/gfe.html>
> or some other free font editor.
> 
> -hpa

I always do it by a BASIC programme under DOS (yep I know
this isn't pure but I have a font editor from S-DOS aka
PTS-DOS (the free version)). The SFE.COM allows me to design
8x8 8x12 8x14 8x16 fonts; the unicode table I write in the
MC or VC (NC clone for DOS) editor; my BASIC pgm converts
them together to PSFU. It's very easy once you read the psf
docs.
It's a pity that I've to mkfs the DOS partitions of my HDDs
every handfull of weeks, otherwise I'd put them onto a ftp
server somewhere. But I call you to try it by yourself.
(perl prolly isn't that easy coz it goes to binary values,
but GW-BASIC is fine)

-mirabilos


