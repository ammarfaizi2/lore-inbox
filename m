Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbTBLU1Y>; Wed, 12 Feb 2003 15:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbTBLU1Y>; Wed, 12 Feb 2003 15:27:24 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:63250 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267578AbTBLU1X>; Wed, 12 Feb 2003 15:27:23 -0500
Date: Wed, 12 Feb 2003 20:37:09 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: New logo code (fwd)
In-Reply-To: <20030205141418.B20077@infradead.org>
Message-ID: <Pine.LNX.4.44.0302122026550.31435-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > All comments are welcomed! Thanks!
> > 
> > Come on, is there really no one to comment on this??
> 
> Except a question why it's not merged yet? :)

Looking for work has keot me busy. I merged it. One change I did do was 
changed the CONFIG_FB_LOGO_* to CONFIG_LOGO_. In theory any one can use 
the logo (i.e newport console). It is a much welcomed improvement. I 
removed the hgafb logo code in the latest tree. It should use the standard 
logo code. Also how should we go about for personal logos. Companies might 
want to throw in there own thing which I have no issue with.


