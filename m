Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288331AbSAMX5Q>; Sun, 13 Jan 2002 18:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288333AbSAMX5H>; Sun, 13 Jan 2002 18:57:07 -0500
Received: from ns.suse.de ([213.95.15.193]:59406 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288331AbSAMX5B>;
	Sun, 13 Jan 2002 18:57:01 -0500
Date: Mon, 14 Jan 2002 00:56:58 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: patch-2.5.1-dj14.diff.gz is broken
In-Reply-To: <20020113210447.GA8215@clt88-175-140.carolina.rr.com>
Message-ID: <Pine.LNX.4.33.0201140055320.7131-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002, Zilvinas Valinskas wrote:

> if I do
> gunzip -t ../patch-2.5.1-dj14.diff.gz
> gunzip: patch-2.5.1-dj14.diff.gz: unexpected end of file

Not sure what happened there, but I just put a fixed version
in place (actually the same one I uploaded, just the mirrored
copy got broken somehow).

Fixed version should be 1582128 bytes, and has the following md5sum

380ffa46db6c37e22d4780f20e341c57  patch-2.5.1-dj14.diff.gz

Thanks for letting me know.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

