Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263603AbUDUSpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUDUSpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUDUSpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:45:49 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:27402 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263603AbUDUSpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:45:46 -0400
Date: Wed, 21 Apr 2004 19:45:45 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jean Delvare <khali@linux-fr.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Permissions on include/video/neomagic.h
In-Reply-To: <20040421204507.2dee599b.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.44.0404211945240.9207-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > In linux-2.6.5.tar, include/video/neomagic.h has permissions 0640.
> > > It obviously should be 0644.
> >
> > I'm preparing new neofb patch for Andrew Morton. They will fix this.
> 
> Just curious... How can a patch change file permissions?

If it is a BK patch I assume that would fix it.


