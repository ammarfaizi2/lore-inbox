Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281759AbRKVU6c>; Thu, 22 Nov 2001 15:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281776AbRKVU6W>; Thu, 22 Nov 2001 15:58:22 -0500
Received: from fungus.teststation.com ([212.32.186.211]:36114 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S281759AbRKVU6L>; Thu, 22 Nov 2001 15:58:11 -0500
Date: Thu, 22 Nov 2001 21:58:06 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Petr Titera <P.Titera@century.cz>
cc: <linux-kernel@vger.kernel.org>, Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Filesize limit on SMBFS
In-Reply-To: <3BFCF740.1030009@century.cz>
Message-ID: <Pine.LNX.4.30.0111222134400.12777-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Petr Titera wrote:

> I'd like to.

http://www.hojdpunkten.ac.se/054/samba/lfs.html

There are some short instructions there. A small change to samba is also
needed, at least with 2.2.2. Although it has been tested, it should not be
trusted. This is experimental code, it may eat your files.

I wrote this some time ago but 2.5 just wouldn't open ... and not enough
testing for 2.4.

/Urban

