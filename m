Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311856AbSDXLeF>; Wed, 24 Apr 2002 07:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311866AbSDXLeE>; Wed, 24 Apr 2002 07:34:04 -0400
Received: from ns.suse.de ([213.95.15.193]:38156 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311856AbSDXLeC>;
	Wed, 24 Apr 2002 07:34:02 -0400
Date: Wed, 24 Apr 2002 13:33:57 +0200
From: Dave Jones <davej@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Larry McVoy <lm@bitmover.com>, Jes Sorensen <jes@wildopensource.com>,
        Jeff Garzik <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020424133357.B14343@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	David Woodhouse <dwmw2@infradead.org>, Larry McVoy <lm@bitmover.com>,
	Jes Sorensen <jes@wildopensource.com>,
	Jeff Garzik <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020423080216.E25771@work.bitmover.com> <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship> <20020421171629.GK4640@zip.com.au> <20020421104046.J10525@work.bitmover.com> <20020421134851.B7828@havoc.gtf.org> <20020421105437.L10525@work.bitmover.com> <m3elh6obt7.fsf@trained-monkey.org> <20020423080216.E25771@work.bitmover.com> <22053.1019639011@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 10:03:31AM +0100, David Woodhouse wrote:

 >  http://ftp.??.kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5/
 >  http://ftp.??.kernel.org/pub/linux/kernel/people/
 > 
 > The individual patches look sane - I'm not entirely sure about the 'Full 
 > patch' version, which seems to contain stuff not in the individual patches.

Just an added vote of confidence,..
They looked sane enough that I used them to sync my tree up to a few
csets short of 2.5.9 over the weekend, (after 2.5.9 final I diffed the
tree with csets -> 2.5.9 and then merged that).

The only time this method of me keeping up with Linus falls over is when
files move or are deleted. No patch seems to be deleted there, so
there's nothing for me to apply.. I can live with this though.


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
