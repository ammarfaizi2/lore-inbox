Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129799AbRB0Ttv>; Tue, 27 Feb 2001 14:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRB0Ttn>; Tue, 27 Feb 2001 14:49:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21509 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129800AbRB0Ttd>; Tue, 27 Feb 2001 14:49:33 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISO-8859-1 completeness of kernel fonts?
Date: 27 Feb 2001 11:49:14 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <97h0bq$kdc$1@cesium.transmeta.com>
In-Reply-To: <F281raFC8XymNMDdckH00012e6f@hotmail.com> <000001c0a0ed$1ea188d0$742c9c3e@tp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <000001c0a0ed$1ea188d0$742c9c3e@tp.net>
By author:    "Thorsten Glaser Geuer" <eccesys@topmail.de>
In newsgroup: linux.dev.kernel
> 
> My second suggestion: code it as .psfu and load it by setfont, including
> the appropiate console-map. AFAIK all the kernel default fonts are cp437
> (linux/drivers/char/cp437.uni; consolemap.*)
> 

Something that would be really good is if someone could contribute PSF
(v1 and v2) support for gfe <http://www.gnu.org/software/gfe/gfe.html>
or some other free font editor.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
