Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265863AbUFITYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbUFITYL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUFITYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:24:11 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:13215 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S265863AbUFITYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:24:01 -0400
Date: Wed, 09 Jun 2004 14:23:58 -0500
From: cbjohns@mn.rr.com
Subject: Re: kswapd excessive CPU time
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Reply-to: cbjohns@mn.rr.com
Message-id: <6feb8721a0.721a06feb8@rdc-kc.rr.com>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.21 (built Sep  8 2003)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Recent 2.4 VM should fix this, but you better of use 2.6.
> 

Thanks Marcelo. Do you know of specific patches that have
gone into 2.4 that might fix this? I may be able to just apply them
rather than try a whole new kernel release.

Thanks,

Chris

> > 
> > My question boils down to this: given the (simple) scenario below,
> > am I missing critical VM/kswapd patches, or is this behavior
> > expected and OK, or is it wrong and possibly fixed in the 2.6 
> kernel?> Or is the kswapd behavior somehow tunable to avoid the 
> apparent> thrashing that I saw? 
> 


