Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267537AbRGXN5E>; Tue, 24 Jul 2001 09:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbRGXN4y>; Tue, 24 Jul 2001 09:56:54 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:14865 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267539AbRGXN4q>; Tue, 24 Jul 2001 09:56:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rusty Russell <rusty@rustcorp.com.au>, Larry McVoy <lm@bitmover.com>
Subject: Re: Common hash table implementation
Date: Tue, 24 Jul 2001 14:28:43 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m15O8ta-000CFtC@localhost>
In-Reply-To: <m15O8ta-000CFtC@localhost>
MIME-Version: 1.0
Message-Id: <01072414284307.00301@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sunday 22 July 2001 04:23, Rusty Russell wrote:
> Interestingly, there's an unused, undocumented hash table interface
> in include/linux/ghash.h.

Yikes:

#define DEF_HASH(LINKAGE,NAME,HASHSIZE,TYPE,PTRS,KEYTYPE,KEY,KEYCMP,KEYEQ,HASHFN)\

--
Daniel
