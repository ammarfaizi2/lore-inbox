Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbUJ0WcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbUJ0WcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUJ0W20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:28:26 -0400
Received: from mail.dif.dk ([193.138.115.101]:59574 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262902AbUJ0W1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:27:46 -0400
Date: Thu, 28 Oct 2004 00:36:03 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Danny Brow <dan@fullmotions.com>
Cc: Kernel-List <linux-kernel@vger.kernel.org>
Subject: Re: SSH and 2.6.9
In-Reply-To: <1098913797.3495.0.camel@hanzo.fullmotions.com>
Message-ID: <Pine.LNX.4.61.0410280034020.3284@dragon.hygekrogen.localhost>
References: <1098906712.2972.7.camel@hanzo.fullmotions.com> 
 <Pine.LNX.4.61.0410272247460.3284@dragon.hygekrogen.localhost> 
 <1098912301.4535.1.camel@hanzo.fullmotions.com> <1098913797.3495.0.camel@hanzo.fullmotions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Danny Brow wrote:

> That was it, thanks.
> 
Ok, thank you for the feedback, glad you fixed your problem. 
Now I guess we just need for someone to find out why LEGACY_PTYS breaks 
ssh (and other apps?) with kernels >= 2.6.9, but I'm afraid thats beyond 
my capabilities.

--
Jesper Juhl


