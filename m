Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265339AbUFHWTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUFHWTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 18:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUFHWTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 18:19:22 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:55740 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265339AbUFHWTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 18:19:22 -0400
Date: Tue, 8 Jun 2004 15:19:13 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: FabF <fabian.frederick@skynet.be>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7-rc3] nr_free_files ?
Message-ID: <20040608221913.GA16473@taniwha.stupidest.org>
References: <1086728685.3865.3.camel@localhost.localdomain> <20040608141712.2da5ace2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608141712.2da5ace2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 02:17:12PM -0700, Andrew Morton wrote:

> It changes the format of /proc/sys/fs/file-nr.

For 2.7.x is think that's fine but clearly for 2.6.x it's not.  Are we
starting to queue stuff for 2.7.x yet? :)


  --cw
