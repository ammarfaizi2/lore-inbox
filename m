Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263464AbUDURKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbUDURKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 13:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbUDURKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 13:10:37 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:23817 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263464AbUDURKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 13:10:36 -0400
Date: Wed, 21 Apr 2004 18:10:27 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jean Delvare <khali@linux-fr.org>
cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Permissions on include/video/neomagic.h
In-Reply-To: <20040418202223.6b226e19.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.44.0404211810070.8561-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm preparing new neofb patch for Andrew Morton. They will fix this.


On Sun, 18 Apr 2004, Jean Delvare wrote:

> Hi all, hi Linus,
> 
> In linux-2.6.5.tar, include/video/neomagic.h has permissions 0640. It
> obviously should be 0644.
> 
> This has already been reported 8 months ago:
> http://lkml.org/lkml/2003/8/9/150
> 
> Shouldn't it be fixed?
> 
> Thanks.
> 
> 

