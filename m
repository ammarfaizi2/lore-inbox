Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUCaPUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 10:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUCaPUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 10:20:19 -0500
Received: from mail.shareable.org ([81.29.64.88]:31380 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261991AbUCaPUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 10:20:16 -0500
Date: Wed, 31 Mar 2004 16:20:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040331152012.GA19280@mail.shareable.org>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040331143412.GA18990@mail.shareable.org> <20040331144536.GA328@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331144536.GA328@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > The garbage collection is what's horrible about it :)
> > Btw, 15 would be exceeded easily in my home directory.
> 
> Well, but chances are that you'll never unlink such files... Leaving
> garbage collection to fsck would make it rather easy.

No, I'd unlink them often.  Every time I clone a source tree, make
some changes, compile, maybe test :), then delete the tree.

I like to fsck maybe once every 6 months.

-- Jamie
