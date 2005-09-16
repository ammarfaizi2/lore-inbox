Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVIPVi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVIPVi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVIPVi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:38:56 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:56994 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751307AbVIPViz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:38:55 -0400
Date: Fri, 16 Sep 2005 15:38:49 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: Ram <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, miklos@szeredi.hu,
       mike@waychison.com, bfields@fieldses.org, serue@us.ibm.com
Subject: Re: [RFC PATCH 1/10] vfs: Lindentified namespace.c
Message-ID: <20050916213849.GI16698@parisc-linux.org>
References: <20050916182619.GA28428@RAM> <20050916142557.691b055e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916142557.691b055e.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 02:25:57PM -0700, Andrew Morton wrote:
> > -repeat:
> > +      repeat:
> 
> Labels go in column zero.

Column 1.  If you put them in column 0, it messes up diff -p.
