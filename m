Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289321AbSAOA0u>; Mon, 14 Jan 2002 19:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289322AbSAOA0k>; Mon, 14 Jan 2002 19:26:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289321AbSAOA0d>; Mon, 14 Jan 2002 19:26:33 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs buffer spec -- second draft
Date: 14 Jan 2002 16:26:05 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1vsut$1qr$1@cesium.transmeta.com>
In-Reply-To: <3C41EA0D.2050205@zytor.com> <3C41EA0D.2050205@zytor.com> <m1elkuq87v.fsf@frodo.biederman.org> <8GpxaCDXw-B@khms.westfalen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <8GpxaCDXw-B@khms.westfalen.de>
By author:    kaih@khms.westfalen.de (Kai Henningsen)
In newsgroup: linux.dev.kernel
> 
> The latest existing formal spec is probably POSIX 2001 (look under "pax").  
> An older POSIX version would have it under "cpio". You'll probably also  
> find it there in Unix98 a.k.a. SuSv2. (POSIX 2001 (the Austin revision)  
> supersedes all of those.)
> 
> It's a bit long to post here - probably exceeds fair use.
> 

POSIX only specifies the "old ASCII" cpio format anyway, which is so
limited as to be useless.  POSIX specifies also specify "ustar" and
"pax", two extended tar formats, neither of which is suitable for this
application.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
