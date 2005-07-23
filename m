Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVGWFkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVGWFkR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 01:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVGWFkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 01:40:16 -0400
Received: from dial169-39.awalnet.net ([213.184.169.39]:20999 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S262361AbVGWFj0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 01:39:26 -0400
Message-Id: <200507230536.IAA03551@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Adrian Bunk'" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>,
       "'christos gentsis'" <christos_gentsis@yahoo.co.uk>,
       <david.lang@digitalinsight.com>
Subject: RE: kernel optimization
Date: Sat, 23 Jul 2005 08:35:35 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcWO+Zgdy70hol3nT6KpCzrwU5+ZOwARUBPA
In-Reply-To: <20050722201416.GM3160@stusta.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Adrian Bunk wrote: {
On Fri, Jul 22, 2005 at 07:55:48PM +0100, christos gentsis wrote:
> i would like to ask if it possible to change the optimization of the 
> kernel from -O2 to -O3 :D, how can i do that? if i change it to the 
> top level Makefile does it change to all the Makefiles?
And since it's larger, it's also slower.
}

It's faster but it's flawed.  Root-NFS boot failed!

