Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316010AbSEOHeh>; Wed, 15 May 2002 03:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSEOHeg>; Wed, 15 May 2002 03:34:36 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:51972
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S316010AbSEOHeg>; Wed, 15 May 2002 03:34:36 -0400
Date: Wed, 15 May 2002 09:34:31 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Andre LeBlanc <ap.leblanc@shaw.ca>
Cc: linux-kernel@vger.kernel.org, debian-testing@lists.debian.org
Subject: Re: No Network after Compiling, 2.4.19-pre8 under Debian Woody
Message-ID: <20020515093431.B13317@bouton.inet6-interne.fr>
Mail-Followup-To: Andre LeBlanc <ap.leblanc@shaw.ca>,
	linux-kernel@vger.kernel.org, debian-testing@lists.debian.org
In-Reply-To: <003c01c1fb9d$345e0a20$2000a8c0@metalbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 04:15:14PM -0700, Andre LeBlanc wrote:
> [...]
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_MMAP is not set
> # CONFIG_NETLINK_DEV is not set

Try with 
CONFIG_NETLINK_DEV=y or m

> [...]

LB.
