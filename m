Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVCBXRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVCBXRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVCBXOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:14:41 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:22144 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261201AbVCBXK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:10:59 -0500
Subject: Re: RFD: Kernel release numbering
From: Josh Boyer <jdub@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 17:10:07 -0600
Message-Id: <1109805008.8290.4.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 14:21 -0800, Linus Torvalds wrote:
> It seems like a sensible approach, and it's not like the 2.4.x vs 2.5.x
> kind of even/odd thing didn't _work_, the problems really were an issue of
> too big granularity making it hard for user and developers alike. So I see
> this as a tweak of the "let's drop the notion althogether for now"  
> decision, and just modify it to "even/odd is meaningful at all levels".

I like it, but what about important security fixes or mistakes like
2.6.8.1?  In those situations, would you release that kernel under the
next even number and skip the odd number?  Or would you release the fix
under an odd number and sorta throw off the "meaning"?

I'm not trying to be a pain, I'm really not.

josh

