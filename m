Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSEWTv0>; Thu, 23 May 2002 15:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSEWTvZ>; Thu, 23 May 2002 15:51:25 -0400
Received: from fungus.teststation.com ([212.32.186.211]:65293 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S316996AbSEWTvZ>; Thu, 23 May 2002 15:51:25 -0400
Date: Thu, 23 May 2002 21:51:00 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: Florian Hars <hars@bik-gmbh.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.28/smbfs] Unable to handle kernel paging request
In-Reply-To: <20020523175927.GA16387@bik-gmbh.de>
Message-ID: <Pine.LNX.4.33.0205232149540.21909-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2002, Florian Hars wrote:

> May 23 17:34:36 counter kernel: Unable to handle kernel paging request
> at virtual address d0000000

Apply this:
http://www.hojdpunkten.ac.se/054/samba/00-smbfs-2.4.18-codepage.patch.gz

Or upgrade to 2.4.19-preX.

/Urban

