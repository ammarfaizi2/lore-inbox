Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTBOPtV>; Sat, 15 Feb 2003 10:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTBOPtV>; Sat, 15 Feb 2003 10:49:21 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:34442 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262780AbTBOPtV>; Sat, 15 Feb 2003 10:49:21 -0500
From: Oliver Neukum <oliver@neukum.name>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: clean up SLAB_KERNEL non-usage
Date: Sat, 15 Feb 2003 16:58:58 +0100
User-Agent: KMail/1.5
References: <20030215114054.GA32256@holomorphy.com>
In-Reply-To: <20030215114054.GA32256@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302151658.59007.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 15. Februar 2003 12:40 schrieb William Lee Irwin III:
> Use SLAB_KERNEL and SLAB_ATOMIC instead of GFP_KERNEL and GFP_ATOMIC
> when passing args to slab allocation functions.

What is this distinction supposed to do anyway?
Can't we just drop it?

	Regards
		Oliver

