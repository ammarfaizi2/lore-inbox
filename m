Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRHRUeQ>; Sat, 18 Aug 2001 16:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbRHRUeG>; Sat, 18 Aug 2001 16:34:06 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:34827 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S267196AbRHRUdw>; Sat, 18 Aug 2001 16:33:52 -0400
Date: Sat, 18 Aug 2001 16:34:06 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: s/fs\/uni/fs\/ntfs\/uni/
Message-ID: <20010818163406.D6893@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <20010818163039.C6893@mueller.datastacks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010818163039.C6893@mueller.datastacks.com>; from crutcher@datastacks.com on Sat, Aug 18, 2001 at 04:30:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 18/08/01 16:30 -0400 - Crutcher Dunnavant:
> Subject pretty much says it all, fs/unistr.h uses min(),
Subject pretty much says it all, fs/ntfs/unistr.h uses min(),

oopse. But the patch still holds.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
