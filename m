Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUKDCmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUKDCmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbUKDCmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:42:09 -0500
Received: from [12.177.129.25] ([12.177.129.25]:10180 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261174AbUKDCjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:39:43 -0500
Message-Id: <200411040451.iA44pJ5G012816@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: blaisorblade_spam@yahoo.it, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       cw@f00f.org
Subject: Re: [patch 09/20] uml: use SIG_IGN for empty sighandler 
In-Reply-To: Your message of "Thu, 04 Nov 2004 00:17:35 +0100."
             <20041103231735.8C1E955C79@zion.localdomain> 
References: <20041103231735.8C1E955C79@zion.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Nov 2004 23:51:19 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade_spam@yahoo.it said:
> Avoid creating a dummy no-op procedure instead of using SIG_IGN. 

Andrew, can you hold off on this one?  I did that on purpose, and as soon
as I remember why, I'll know whether this patch is good :-)

The other patches are OK by me.  Consider them acked.

				Jeff

