Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSGVLKv>; Mon, 22 Jul 2002 07:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSGVLKu>; Mon, 22 Jul 2002 07:10:50 -0400
Received: from verein.lst.de ([212.34.181.86]:28682 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S316792AbSGVLKt>;
	Mon, 22 Jul 2002 07:10:49 -0400
Date: Mon, 22 Jul 2002 13:13:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 sysctl
Message-ID: <20020722131354.A17077@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, martin@dalecki.de,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> <3D3BE17F.3040905@evision.ag> <20020722125347.B16685@lst.de> <3D3BE4C7.2060203@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D3BE4C7.2060203@evision.ag>; from dalecki@evision.ag on Mon, Jul 22, 2002 at 12:56:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 12:56:07PM +0200, Marcin Dalecki wrote:
> It's an GNU-ism.

Actually I've looked it up in my copy of the last C99 draft:

	[#5]  This  edition  replaces  the previous edition, ISO/IEC |
	9899:1990,   as   amended   and   corrected    by    ISO/IEC |
	9899/COR1:1994,    ISO/IEC   9899/COR2:1995,   and   ISO/IEC |
	9899/AMD1:1995.  Major changes  from  the  previous  edition |
	include:

	[some stuff snipped]

  	  -- trailing comma allowed in enum declaration              |

So please let it in.

