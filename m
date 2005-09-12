Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVILUja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVILUja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVILUja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:39:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21456 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932128AbVILUj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:39:29 -0400
Date: Mon, 12 Sep 2005 21:39:28 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] n_r3964: drop bogus fmt casts
Message-ID: <20050912203928.GP25261@ZenIV.linux.org.uk>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912204251.GA18962@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912204251.GA18962@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 12:42:52AM +0400, Alexey Dobriyan wrote:
> * print pointers with %p
> * casting unsigned int structure field to int and printing it with %d...
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

ACK and merged.
