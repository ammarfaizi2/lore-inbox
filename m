Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284875AbRLEXy6>; Wed, 5 Dec 2001 18:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284842AbRLEXwl>; Wed, 5 Dec 2001 18:52:41 -0500
Received: from ns.suse.de ([213.95.15.193]:11794 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284859AbRLEXwN>;
	Wed, 5 Dec 2001 18:52:13 -0500
Date: Thu, 6 Dec 2001 00:52:11 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Simon Kirby <sim@netnation.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FS] Why doesn't this patch work?
In-Reply-To: <20011205152834.A11289@netnation.com>
Message-ID: <Pine.LNX.4.33.0112060051130.18145-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Simon Kirby wrote:

> buffer.c:409: warning: assignment from incompatible pointer type

> +	struct vfsmnt * mnt;

vfsmount perhaps ?

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

