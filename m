Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSEGSDQ>; Tue, 7 May 2002 14:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315924AbSEGSDP>; Tue, 7 May 2002 14:03:15 -0400
Received: from www.transvirtual.com ([206.14.214.140]:49936 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315923AbSEGSDP>; Tue, 7 May 2002 14:03:15 -0400
Date: Tue, 7 May 2002 11:02:53 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Greg KH <greg@kroah.com>
cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] 2.5.14 oops in fb_copy_cmap
In-Reply-To: <20020506170357.GA3798@kroah.com>
Message-ID: <Pine.LNX.4.10.10205071102120.30751-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I get the oops below at boot time if "vga=0x0305" is on the command
> line.  If I take it off, I can boot just fine.

Hm. Can you wait a few days. I'm porting the vesa driver to the new api. I
will soon release a new driver.

