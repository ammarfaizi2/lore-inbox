Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWJRJeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWJRJeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWJRJep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:34:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57319 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750785AbWJRJeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:34:44 -0400
Date: Wed, 18 Oct 2006 10:34:33 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, jsipek@fsl.cs.sunysb.edu, linux-kernel@vger.kernel.org,
       hch@infradead.org, mhalcrow@us.ibm.com, penberg@cs.helsinki.fi,
       linux-fsdevel@vger.kernel.org
Subject: Re: fsstack: struct path
Message-ID: <20061018093433.GN29920@ftp.linux.org.uk>
References: <20061018042323.GA8537@filer.fsl.cs.sunysb.edu> <20061018013103.4ad6311a.akpm@osdl.org> <20061018013551.3745e1d5.akpm@osdl.org> <20061018090623.GK29920@ftp.linux.org.uk> <20061018021222.2c4d907c.akpm@osdl.org> <20061018092241.GL29920@ftp.linux.org.uk> <20061018022747.d1d9ee5c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018022747.d1d9ee5c.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 02:27:47AM -0700, Paul Jackson wrote:
> > struct path_node
> 
> or just struct pathnode ?

as long as it's not path_thingy (or path_turnip)...
