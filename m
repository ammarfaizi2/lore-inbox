Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292368AbSBYWlz>; Mon, 25 Feb 2002 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292370AbSBYWlo>; Mon, 25 Feb 2002 17:41:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18701 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292375AbSBYWkv>; Mon, 25 Feb 2002 17:40:51 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.4.18 - Full tarball is OK
Date: 25 Feb 2002 14:40:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a5eegv$10o$1@cesium.transmeta.com>
In-Reply-To: <E16fTkG-0006VG-00@the-village.bc.nu> <Pine.LNX.4.33L.0202251931360.7820-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33L.0202251931360.7820-100000@imladris.surriel.com>
By author:    Rik van Riel <riel@conectiva.com.br>
In newsgroup: linux.dev.kernel
>
> On Mon, 25 Feb 2002, Alan Cox wrote:
> 
> > If so Marcelo can you put up 2.4.18-fixed patch and a borked-fixed diff ?
> That would break hpa's incremental diff patches.
> If somebody needs 2.4.18 + fix, they can just run 2.4.18-rc4.
> 

Since the tarball apparently is OK and it's only the patch that's
different, just re-create the patch, put it in the proper place, and
make sure the file date on the patch is different; the incremental
diff will be regenerated to match.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
