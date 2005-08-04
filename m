Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVHDTgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVHDTgo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVHDTgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:36:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262499AbVHDTgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:36:42 -0400
Date: Thu, 4 Aug 2005 12:38:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: francoisgrand@free.fr
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: system freeze on USB plug
Message-Id: <20050804123834.0c4e7f91.akpm@osdl.org>
In-Reply-To: <1119108450.42b43d62e7c20@imp6-q.free.fr>
References: <1119108450.42b43d62e7c20@imp6-q.free.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

francoisgrand@free.fr wrote:
>
> I'd like to report a system freeze happening on USB device plug.

Many others reported similar problems.  There have been many weird USB
problems reported across the 2.6.13 cycle and I've lost the plot on which
ones remain unfixed and which ones are regressions since 2.6.12.

So I'm going to stop tracking all non-bugzilla'ed USB bug reports.  -rc6
will be out soon - if anyone still has USB problems in rc6 which aren't in
bugzilla, then please get them in there, thanks.
