Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWH3Wop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWH3Wop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWH3Wop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:44:45 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:25827 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751132AbWH3Woo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:44:44 -0400
Date: Thu, 31 Aug 2006 00:41:02 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
In-Reply-To: <20060830214356.GO18276@stusta.de>
Message-ID: <Pine.LNX.4.64.0608310039440.6761@scrub.home>
References: <20060825142753.GK10659@infradead.org>
 <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
 <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
 <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com>
 <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de>
 <44F44B8D.4010700@s5r6.in-berlin.de> <Pine.LNX.4.64.0608300311430.6761@scrub.home>
 <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Aug 2006, Adrian Bunk wrote:

> USB_STORAGE switched from a depending on SCSI to select'ing SCSI three 
> years ago, and ATA in 2.6.19 will also select SCSI for a good reason:

It was already silly three years ago.

> When doing anything kconfig related, you must always remember that the 
> vast majority of kconfig users are not kernel hackers.

What does that mean, that only kernel hackers can read?

bye, Roman
