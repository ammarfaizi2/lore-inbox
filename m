Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSEYVUr>; Sat, 25 May 2002 17:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315410AbSEYVUq>; Sat, 25 May 2002 17:20:46 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:59152
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S315388AbSEYVUq>; Sat, 25 May 2002 17:20:46 -0400
Date: Sat, 25 May 2002 23:20:44 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isofs unhide option:  troubles with Wine
Message-ID: <20020525232044.B18560@bouton.inet6-interne.fr>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1022301029.2443.28.camel@jwhiteh> <acopak$1th$1@penguin.transmeta.com> <acosbi$2lr$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 01:31:46PM -0700, H. Peter Anvin wrote:
> [...]
> I think we should just dump the hidden bit; if someone wants it they
> can ioctl() for it.
> 

I didn't know we could and couldn't find how from a quick look-through in
fs/. Is the ioctl really implemented ? If so where should I look ?
That would be good news for Wine as they would have a way to populate the
flags member of the struct.

LB.
