Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVB1VEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVB1VEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVB1VBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:01:24 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:22975 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261742AbVB1VAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:00:20 -0500
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 32bit emulation problems
Date: Mon, 28 Feb 2005 22:00:11 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@muc.de>, nfs@lists.sourceforge.net, bernd-schubert@gmx.de
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
In-Reply-To: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502282200.12784.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As usual we are using unfs3 for /etc and /var, but for me that looks like a
> client problem. I'm even not sure if this is limited to NFS at all.

Sorry, that was easy to test, of course. This problem doesn't seem to exist on 
a local disk.
