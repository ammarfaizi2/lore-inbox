Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUHEVh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUHEVh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUHEVhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:37:22 -0400
Received: from the-village.bc.nu ([81.2.110.252]:8895 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267993AbUHEVhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:37:02 -0400
Subject: Re: FW: Linux kernel file offset pointer races
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <XFMail.20040805104213.pochini@shiny.it>
References: <XFMail.20040805104213.pochini@shiny.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091738068.8364.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 21:34:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-05 at 09:42, Giuliano Pochini wrote:
> I don't remember if this issue has already been discussed here:

Its mostly been discussed on vendor-sec so far. Paul was gracious enough
to give everyone time to work on the problem. Al Viro did some original
patches, various folks then moved them to 2.6 and fixed other stuff from
further review.

Andrew has 2.6 draft patches, Marcelo actively worked on the 2.4 ones
(and some 2.6 glitches). If you need 2.6 patches "right now" then one
place to grab them is from the current Fedora 2 kernel.

Alan

