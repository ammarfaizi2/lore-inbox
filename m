Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVBXQ7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVBXQ7e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVBXQ7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:59:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:6301 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262405AbVBXQ7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:59:32 -0500
Date: Thu, 24 Feb 2005 09:00:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Brian Gerst <bgerst@didntduck.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5
In-Reply-To: <421E011E.6030709@didntduck.org>
Message-ID: <Pine.LNX.4.58.0502240859170.18997@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
 <421E011E.6030709@didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Feb 2005, Brian Gerst wrote:
> 
> It looks like the v2.6.11-rc5 tag is on the same revisions as 2.6.10. 
> patch-2.6.11-rc5 is an empty file, and patch-2.6.11-rc4-rc5 indicates 
> that 2.6.11-rc5 reverted to 2.6.10:

The correct -rc5 patch (as opposed to the empty one) should be there now.  
It might take a bit of time for mirrors and the automated scripts to 
notice.

(And I fixed my release-script)

		Linus
