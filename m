Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbTFRElz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 00:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265070AbTFRElz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 00:41:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37645 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265067AbTFREly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 00:41:54 -0400
Date: Tue, 17 Jun 2003 21:55:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS autmounter support
In-Reply-To: <6516.1055861757@warthog.warthog>
Message-ID: <Pine.LNX.4.44.0306172154200.5369-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jun 2003, David Howells wrote:
> 
> The attached patch adds automounting support and mountpount expiry support to
> the VFS.

I don't think this is evil, but it looks a bit non-appropriate for now. 
But I'd like to see Al's (and others) comments on it..

		Linus

