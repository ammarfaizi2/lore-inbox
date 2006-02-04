Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946143AbWBDK4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946143AbWBDK4w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 05:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946144AbWBDK4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 05:56:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35306 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946143AbWBDK4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 05:56:52 -0500
Date: Sat, 4 Feb 2006 10:56:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       hch@infradead.org
Subject: Re: unexport lookup_hash
Message-ID: <20060204105649.GA27514@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060203212259.GA11066@redhat.com> <20060203223224.GT4408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203223224.GT4408@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 11:32:24PM +0100, Adrian Bunk wrote:
> On Fri, Feb 03, 2006 at 04:22:59PM -0500, Dave Jones wrote:
> > I just stumbled across this whilst checking for planned feature removal,
> > and missed any discussion why this didn't happen, so I assume Christoph forgot.
> >...
> 
> I did beat you by a few minutes.  :-)

and your patch also makes it static which is possible now.  Andrew also queued
up the patch already, so this one won't apply anymore.
