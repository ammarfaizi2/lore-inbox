Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVFUNCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVFUNCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVFUNCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:02:03 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:8112 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261350AbVFUM6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:58:48 -0400
Date: Tue, 21 Jun 2005 14:58:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050621125848.GB7139@wohnheim.fh-wedel.de>
References: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 June 2005 23:54:58 -0700, Andrew Morton wrote:
> 
> execute-in-place
> 
>     Will merge.  Have the embedded guys commented on the usefulness of
>     this for execute-out-of-ROM?

It looks fairly useful, but XIP for NOR flashes still needs additional
work.  No objections from my side.

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 
