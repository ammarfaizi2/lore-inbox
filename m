Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVBFRua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVBFRua (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVBFRu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:50:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6017 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261253AbVBFRu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:50:26 -0500
Date: Sun, 6 Feb 2005 17:50:25 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-ac12
Message-ID: <20050206175025.GO8859@parcelfarce.linux.theplanet.co.uk>
References: <1107695728.14782.170.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107695728.14782.170.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 04:02:42PM +0000, Alan Cox wrote:
> 2.6.10-ac12
> +	Fix a bug in the new vma checks			(Rik van Riel)
> *	Several small 64bit sign/cleanness fixes	(George Guninski)
> *	tty layer typo fix				(Al Viro)

Not mine.  From changeset:
# ChangeSet
#   2005/02/02 08:48:23-08:00 pavenis@latnet.lv
...
#   Acked-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>

