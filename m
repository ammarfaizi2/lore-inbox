Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVHJTFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVHJTFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbVHJTFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:05:05 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:24235 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030203AbVHJTFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:05:03 -0400
Date: Wed, 10 Aug 2005 15:04:21 -0400
From: Tom Vier <tmv@comcast.net>
To: Shaun Jackman <sjackman@gmail.com>
Cc: debian-boot@lists.debian.org, debian-user@debian.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: SATALink Sil3112 and Linux woes
Message-ID: <20050810190421.GA11855@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <7f45d9390508081645c1afd1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f45d9390508081645c1afd1c@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 11:45:22PM +0000, Shaun Jackman wrote:
> I have a Silicon Image SATALink Sil3112 PCI card connected to two 200
> GB SATA Seagate drives.  I'm running into many problems with this
> setup. Is this card well supported under Linux? If it's a black sheep,
> could someone please recommend a PCI SATA card that works well?

What's the model number? You can the source for it, to see if it's
blacklisted.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
