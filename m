Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbTCXHZ7>; Mon, 24 Mar 2003 02:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261468AbTCXHZ7>; Mon, 24 Mar 2003 02:25:59 -0500
Received: from angband.namesys.com ([212.16.7.85]:52362 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261424AbTCXHZ7>; Mon, 24 Mar 2003 02:25:59 -0500
Date: Mon, 24 Mar 2003 10:37:01 +0300
From: Oleg Drokin <green@namesys.com>
To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Cc: jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] devfs_mk_symlink simplification
Message-ID: <20030324103701.A22971@namesys.com>
References: <20030322183938.B21623@lst.de> <20030324103255.A20753@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324103255.A20753@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Mar 24, 2003 at 10:32:55AM +0300, Oleg Drokin wrote:
> On Sat, Mar 22, 2003 at 06:39:38PM +0100, Christoph Hellwig wrote:
> > All devfs_mk_symlink arguments except the from and to strings are
> > unused.  Bring the prototype in shape.
> This patch is needed in UML subtree now:

Argh, this patch is only relevant to patched Jeff's tree, everybody else
please ignore it.

Bye,
    Oleg
