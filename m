Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSF3XrJ>; Sun, 30 Jun 2002 19:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSF3XrI>; Sun, 30 Jun 2002 19:47:08 -0400
Received: from mx1.eskimo.com ([204.122.16.48]:17939 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S314529AbSF3XrI>;
	Sun, 30 Jun 2002 19:47:08 -0400
Date: Sun, 30 Jun 2002 16:49:32 -0700
From: James Gale <jimg@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: PCI: System does not support PCI
Message-ID: <20020630164932.B22175@eskimo.eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I'm posting this in hope that someone can explain the problem
I am seeing, or corroborate my story.  I'm not subscribed to this
list so please CC me on any replies.  I've moved my old hard-disk 
with a 2.4 kernel to a new computer and tried to boot it up.  I 
get a strange message when I do that:

	PCI: System does not support PCI

I don't have a /proc/pci file after boot-up either.

The new computer is an Athlon based Shuttle FS40 motherboard which,
of course, has a PCI bus.  So what would cause the kernel to think
that this board doesn't support PCI?  I've fooled with a few different
kernels that all give this error, but mostly I'm trying to boot my
stock Debian 2.4.18 kernel.  Has anybody else seen this problem?

				Thanks,
				Jim

