Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUDEIqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUDEIqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:46:46 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:34978 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263169AbUDEIqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:46:00 -0400
Date: Mon, 5 Apr 2004 10:45:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Ross Biro <ross.biro@gmail.com>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405084551.GF28924@wohnheim.fh-wedel.de>
References: <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <2B32499D.222B761B@mail.gmail.com> <20040405081231.GB28924@wohnheim.fh-wedel.de> <20040405081908.GB29705@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040405081908.GB29705@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 April 2004 10:19:08 +0200, Pavel Machek wrote:
> 
> BTW what about the "mix hardlinks with cowlinks" proposal? You said it
> leads to hell and then I did not hear from you. Did it scare you that
> much? ;-)

It did in the beginning.  Over the weekend (without mail access) I
pretty much found the same solution you did, but without your
insistence, I hadn't even though about it.  All glory to you! ;)

Jörn

-- 
A surrounded army must be given a way out.
-- Sun Tzu
