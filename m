Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWDTGjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWDTGjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 02:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWDTGjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 02:39:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56301 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751137AbWDTGjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 02:39:13 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, lkml@lpbproductions.com
Subject: Re: [discuss] Re: [PATCH] [1/2] i386/x86-64: Fix x87 information leak between  processes
Date: Thu, 20 Apr 2006 08:39:00 +0200
User-Agent: KMail/1.9.1
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbeulich@novell.com, richard.brunner@amd.com
References: <4446D79D.mailOX9112Y1O@suse.de> <200604192328.39429.lkml@lpbproductions.com>
In-Reply-To: <200604192328.39429.lkml@lpbproductions.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604200839.00606.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 April 2006 08:28, Matt Heler wrote:
> Patch says 1/2 . Is there another patch that comes with this ? Or is vger 
> lagging again ? 

The other patch was a unrelated x86-64 only patch which I normally
not cc to linux-kernel, but only to discuss@x86-64.org. You 
can check it out in the archives.

-Andi
