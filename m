Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314608AbSDTMkl>; Sat, 20 Apr 2002 08:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314609AbSDTMkk>; Sat, 20 Apr 2002 08:40:40 -0400
Received: from fungus.teststation.com ([212.32.186.211]:30472 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S314608AbSDTMkj>; Sat, 20 Apr 2002 08:40:39 -0400
Date: Sat, 20 Apr 2002 14:40:31 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: O_LARGEFILE support in smbfs?
In-Reply-To: <Pine.LNX.4.44.0204201411140.10869-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0204201436490.1218-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Apr 2002, Roy Sigurd Karlsbakk wrote:

> hi
> 
> I'm having problems accessing large files (>2GB) across a mounted share on 
> a win2k server. Is this a known problem?
> 
> I'm running 2.4.18

2.4.18 or 2.4.18 with patches that enable large file support in smbfs?

Patches are currently available from
	http://www.hojdpunkten.ac.se/054/samba/index.html
(don't miss the samba patch and additional mount option).

If you are using a patched 2.4.18 I'd like some more details on what the 
problems are.

/Urban

