Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbUDBQsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbUDBQsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:48:04 -0500
Received: from mailwasher.lanl.gov ([192.16.0.25]:16279 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264102AbUDBQsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:48:00 -0500
Subject: Re: Hot kernel change
From: Steven Cole <elenstev@mesatop.com>
To: Yann Dirson <ydirson@altern.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040402161620.GH22205@bylbo.nowhere.earth>
References: <20040402161620.GH22205@bylbo.nowhere.earth>
Content-Type: text/plain
Message-Id: <1080924316.2206.38.camel@spc0.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-4mdk 
Date: Fri, 02 Apr 2004 09:45:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-02 at 09:16, Yann Dirson wrote:
> Jim Richardson wrote:
> >MkLinux was available for x86, but I have no idea if it is still in
> >development. To be clear, it doesn't allow you to simply replace a
> >kernel, but to add a second one, and possibly, to start transferring
> >over tasks to it. 
> 
> Aside from mklinux, there is the L4Linux option, based on a more modern
> microkernel than Mach, and supporting x86.
> 
> See http://www.l4ka.org/projects/l4linux/

For folks interested in developing/testing various fast boot or possible
future kernel hot swap projects, there is a mailing list here:

http://lists.osdl.org/mailman/listinfo/fastboot

Steven



