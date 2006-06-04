Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932269AbWFDVyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWFDVyl (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWFDVyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:54:41 -0400
Received: from canuck.infradead.org ([205.233.218.70]:49076 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932269AbWFDVyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:54:40 -0400
Subject: Re: kbuild, kconfig and hrdinstall stuff
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060604214102.GA18392@mars.ravnborg.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060604214102.GA18392@mars.ravnborg.org>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 22:54:31 +0100
Message-Id: <1149458071.30024.23.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 23:41 +0200, Sam Ravnborg wrote:
> Dave Woodhouse asked me to review the hdrinstall part and I will do
> so.
> At first glance only a fiw tid-bits needs fixing and then I like to
> include unifdef in the kernel. It is rather unusual to have installed
> (gentoo at least does not have it in Portage).

I'm happy enough to include unifdef -- I'll do it right now if there's
consensus. I just didn't want to do it and then have its inclusion be a
_problem_ -- I wanted the tree to be as simple as possible.

-- 
dwmw2

