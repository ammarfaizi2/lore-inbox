Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267626AbUHZFSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267626AbUHZFSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 01:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267645AbUHZFSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 01:18:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59526 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267623AbUHZFSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 01:18:48 -0400
Date: Thu, 26 Aug 2004 01:17:16 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Nicholas Miell <nmiell@gmail.com>
cc: Matt Mackall <mpm@selenic.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, <torvalds@osdl.org>, <reiser@namesys.com>,
       <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <1093496948.2748.69.camel@entropy>
Message-ID: <Xine.LNX.4.44.0408260114470.28318-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004, Nicholas Miell wrote:

> (BTW, for email, multipart/parallel is a start, but a specific multipart
> content type for multi-stream file attachments would probably be more
> appropriate.)

I don't understand why something like this is so important that it needs 
underlying VFS support.  Multipart messages seem to have survived fine up 
until now.  Where is the justification?


- James
-- 
James Morris
<jmorris@redhat.com>


