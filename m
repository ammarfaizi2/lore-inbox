Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUHYW45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUHYW45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUHYWyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:54:00 -0400
Received: from verein.lst.de ([213.95.11.210]:50629 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266291AbUHYWvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:51:31 -0400
Date: Thu, 26 Aug 2004 00:51:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Spam <spam@tnonline.net>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825225115.GA19808@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, Spam <spam@tnonline.net>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112698263.20040826005146@tnonline.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   This last sentence makes me wonder. Where is Linux heading? The idea
>   that   a  FS  cannot  contain  features that no other FS has is very
>   scary.
> 
>   I  am  all  for  uniformity, but not at the expense of shutting down
>   advanced progress that Linux is so badly needing.
> 
>   This talk about old UNIX seems like people want to still live in the
>   70'ies and not look forward. Please wake up!

Just because semantics are at the VFS layer doesn't mean every
filesystem has to implement them.

