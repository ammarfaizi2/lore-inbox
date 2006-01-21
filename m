Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWAUVuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWAUVuz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWAUVuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:50:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60636 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932393AbWAUVuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:50:54 -0500
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@redhat.com, bunk@stusta.de, linux-kernel@vger.kernel.org,
       pbadari@us.ibm.com, kenneth.w.chen@intel.com
In-Reply-To: <20060121133503.353ad1be.akpm@osdl.org>
References: <20060119030251.GG19398@stusta.de>
	 <20060118194103.5c569040.akpm@osdl.org>
	 <1137833547.2978.7.camel@laptopd505.fenrus.org>
	 <20060121194102.GB28051@redhat.com> <20060121131718.1b6bbcdc.akpm@osdl.org>
	 <1137878739.23974.23.camel@laptopd505.fenrus.org>
	 <20060121133503.353ad1be.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 22:50:50 +0100
Message-Id: <1137880250.23974.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 13:35 -0800, Andrew Morton wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > another thing we really should do is making such "obsolete to be phased
> >  out" things printk (at least once per boot ;) so that people see it in
> >  their logs, not just in the kernel source.
> 
> Like sys_bdflush() has been doing for 3-4 years.  That still comes out on
> a few of my test boxes, but I'm a distro recidivist.

so it works ;)

if you were a distro maker or a userland software developer you'd notice
and change (just like non-paleontic distro makers did ;)..


