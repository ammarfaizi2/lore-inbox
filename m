Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVBOCQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVBOCQk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 21:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVBOCQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 21:16:40 -0500
Received: from [81.2.110.250] ([81.2.110.250]:1240 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261596AbVBOCQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 21:16:37 -0500
Subject: Re: aacraid fails under kernel 2.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jonathan Knight <jonathan@cs.keele.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1Czbmu-0006yr-00@nina.cs.keele.ac.uk>
References: <E1Czbmu-0006yr-00@nina.cs.keele.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108429876.23533.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Feb 2005 01:11:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-02-11 at 14:28, Jonathan Knight wrote:
> Fedora and the 2.6 kernel nothing has worked well.  The latest 2.6.10 build
> is the worst so far.  We've even gone and unpacked the rc3 for 2.6.11 and
> dug out the aacraid controller but that didn't perform any better.  We think
> 2.6.8 was the most usable of the 2.6's so far.

Fedora 2.6.10 or the base 2.6.10. The base 2.6.10 is missing at least
one aacraid fix.

