Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129284AbRB0VTs>; Tue, 27 Feb 2001 16:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129537AbRB0VTj>; Tue, 27 Feb 2001 16:19:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:55818 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129339AbRB0VTd>; Tue, 27 Feb 2001 16:19:33 -0500
Message-ID: <3A9C19CB.7176092B@transmeta.com>
Date: Tue, 27 Feb 2001 13:19:07 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Thorsten Glaser Geuer <eccesys@topmail.de>
CC: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISO-8859-1 completeness of kernel fonts?
In-Reply-To: <F281raFC8XymNMDdckH00012e6f@hotmail.com> <000001c0a0ed$1ea188d0$742c9c3e@tp.net> <97h0bq$kdc$1@cesium.transmeta.com> <036601c0a0f8$bd0ad070$742c9c3e@tp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Glaser Geuer wrote:
> 
> I always do it by a BASIC programme under DOS (yep I know
> this isn't pure but I have a font editor from S-DOS aka
> PTS-DOS (the free version)). The SFE.COM allows me to design
> 8x8 8x12 8x14 8x16 fonts; the unicode table I write in the
> MC or VC (NC clone for DOS) editor; my BASIC pgm converts
> them together to PSFU. It's very easy once you read the psf
> docs.
> It's a pity that I've to mkfs the DOS partitions of my HDDs
> every handfull of weeks, otherwise I'd put them onto a ftp
> server somewhere. But I call you to try it by yourself.
> (perl prolly isn't that easy coz it goes to binary values,
> but GW-BASIC is fine)
> 

I published a DOS-based PSF editor a long, long time ago (look for
fontedit.exe; if it isn't on the net anywhere remind me and I'll put it
back up.)  Use psfaddtable then to combine it into PSFU.

However, having something running under Linux would make more sense.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
