Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVBBQ4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVBBQ4F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVBBQ4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:56:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4819 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262586AbVBBQzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:55:55 -0500
Date: Wed, 2 Feb 2005 16:55:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.de>
Subject: Re: [RFC][PATCH 0/3] Access Control Lists for tmpfs and /dev/pts
Message-ID: <20050202165549.GA17924@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
	Chris Mason <mason@suse.de>
References: <20050202161340.660712000@blunzn.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202161340.660712000@blunzn.suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 05:13:40PM +0100, Andreas Gruenbacher wrote:
> Here is a set of three patches which implement some general
> infrastructure and on top of that, acls for tmpfs and /dev/pts files.

Why would you want ACLs on /dev/pts?

