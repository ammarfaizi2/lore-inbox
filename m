Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269220AbUHZS24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269220AbUHZS24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUHZS1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:27:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5317 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269336AbUHZSSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:18:46 -0400
Date: Thu, 26 Aug 2004 14:17:04 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Jeremy Allison <jra@samba.org>
cc: Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       <wichert@wiggy.net>, <torvalds@osdl.org>, <reiser@namesys.com>,
       <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826173227.GB1570@legion.cup.hp.com>
Message-ID: <Pine.LNX.4.44.0408261416360.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Jeremy Allison wrote:

> Because without kernel support there is no way someone can
> publish a new metadata type and have it automatically supported
> by all application data files (ie. most apps ignore it, and only
> apps that are aware of it can see it).

So your backup software ignores it, and after a restore you've
lost your new metadata ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

