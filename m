Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269972AbUJHM5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269972AbUJHM5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 08:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269908AbUJHM5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 08:57:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21176 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269966AbUJHM4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 08:56:47 -0400
Date: Fri, 8 Oct 2004 13:56:43 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: matthew@wil.cx, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] [patch] fix unterminated comment in asm-parisc/som.h
Message-ID: <20041008125643.GP16153@parcelfarce.linux.theplanet.co.uk>
References: <20041008124754.GH5227@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008124754.GH5227@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 02:47:55PM +0200, Adrian Bunk wrote:
> 
> The patch below fixes an unterminated comment in 
> include/asm-parisc/som.h present in both 2.4 and 2.6 .
> 
> This bug was found using David A. Wheeler's 'SLOCCount'.

This file has already been deleted as it is unused.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
