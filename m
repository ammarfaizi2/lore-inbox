Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWFTUoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWFTUoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWFTUoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:44:20 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:29630 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751008AbWFTUoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:44:18 -0400
Date: Tue, 20 Jun 2006 16:44:16 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] [PATCH 0/6] Keys: Key management updates  [try #3]
In-Reply-To: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0606201642050.1262@d.namei>
References: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, David Howells wrote:

> These patches update a few key management related things, mainly security
> related.  They have the following prerequisite patches from Andrew Morton's -mm
> tree:
> 
> 	selinux-add-hooks-for-key-subsystem.patch
> 	keys-fix-race-between-two-instantiators-of-a-key.patch

When do you think these patches will move from -mm into mainline?

I ask because I've got a bunch of SELinux patches lined up behind this 
patchset, which we're aiming for 2.6.18 inclusion.



- James 
-- 
James Morris <jmorris@namei.org>
