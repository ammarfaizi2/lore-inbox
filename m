Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292944AbSCDWWK>; Mon, 4 Mar 2002 17:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292942AbSCDWWA>; Mon, 4 Mar 2002 17:22:00 -0500
Received: from fungus.teststation.com ([212.32.186.211]:5899 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S292941AbSCDWVp>; Mon, 4 Mar 2002 17:21:45 -0500
Date: Mon, 4 Mar 2002 23:21:39 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Kerekfy Peter <kerekfyp@fazekas.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux kernel bug report
In-Reply-To: <Pine.LNX.4.33.0203041729450.10999-600000@pingvin.fazekas.hu>
Message-ID: <Pine.LNX.4.33.0203042310500.16082-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Kerekfy Peter wrote:

> root@athene:~ # cat /proc/version
> Linux version 2.4.18 (root@athene) (gcc version 2.95.3 20010315 (SuSE)) #2
> Sat Mar 2 11:36:17 CET 2002

If you can repeat this on any 2.4.x except 2.4.18 (and it's -rc versions)
I am interested.

Otherwise I believe this is known and that the fix is available as:
  http://www.hojdpunkten.ac.se/054/samba/00-smbfs-2.4.18-codepage.patch.gz

Also in 2.4.18-ac3, and hopefully soon in 2.4.19-pre3.

/Urban

