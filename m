Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVGLXjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVGLXjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVGLXjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:39:00 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:32388 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262405AbVGLXiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:38:24 -0400
Message-ID: <42D45464.2090308@namesys.com>
Date: Tue, 12 Jul 2005 16:38:12 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Stefan Smietanowski <stesmi@stesmi.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
References: <200507120233.j6C2XODw030361@laptop11.inf.utfsm.cl> <42D35AE4.9000400@namesys.com> <42D450BE.70404@slaphack.com>
In-Reply-To: <42D450BE.70404@slaphack.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>
> That's why we're trying to find something that people won't actually
> touch, especially since if we design it right, this will be the last
> delimiter introduced at the fs/vfs level.

Uh, no, there needs to be about a dozen or so more.

But not this year.
