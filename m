Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271825AbTGXX0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271827AbTGXX0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:26:15 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:31237 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271825AbTGXX0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:26:12 -0400
Date: Fri, 25 Jul 2003 00:41:17 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Richard Drummond <lists@rcdrummond.net>
cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Big-endian fixes for tdfxfb in 2.4.21
In-Reply-To: <200307190434.08829.lists@rcdrummond.net>
Message-ID: <Pine.LNX.4.44.0307250040290.7845-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ooops. I apologize. It turns out that I didn't test this as thoroughly as I 
> had thought. Although the Voodoo3 works perfectly, 16-bit and 32-bit modes  
> are still broken on the Voodoo4.

I have a Voodoo 5 so I can give it a try this week end. I don't have docs 
on the latest cards. I will apply the patch to 2.5.X this weekend.




