Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSEUX6m>; Tue, 21 May 2002 19:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSEUX6l>; Tue, 21 May 2002 19:58:41 -0400
Received: from fungus.teststation.com ([212.32.186.211]:7953 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S316793AbSEUX6k>; Tue, 21 May 2002 19:58:40 -0400
Date: Wed, 22 May 2002 01:58:32 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <samba@samba.org>
Subject: Re: [Samba] smbfs related oops
In-Reply-To: <Pine.LNX.4.44.0205211919370.1752-100000@grignard.amagerkollegiet.dk>
Message-ID: <Pine.LNX.4.33.0205220155440.21569-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002, Rasmus Bøg Hansen wrote:

> Linux version 2.4.18 (root@gere) (gcc version 2.95.2 20000220 (Debian 
...
> Unable to handle kernel paging request at virtual address c4000000

Apply this, or upgrade to 2.4.19-preX.

http://www.hojdpunkten.ac.se/054/samba/00-smbfs-2.4.18-codepage.patch.gz

/Urban

