Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267999AbUH2PHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267999AbUH2PHS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUH2PHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:07:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:4225 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267999AbUH2PHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:07:05 -0400
Subject: Re: pwc+pwcx is not illegal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kenneth Lavrsen <kenneth@lavrsen.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040828131138.GZ12772@fs.tum.de>
References: <6.1.2.0.2.20040828141825.01e5e7d8@inet.uni2.dk>
	 <20040828131138.GZ12772@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093788177.27901.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 15:02:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-28 at 14:11, Adrian Bunk wrote:
> There was a hook for a binary-only module in the kernel, and as soon as 
> Greg was made aware of it he removed it.

Sure - removing hooks good, removing entire driver when its still useful
*BAD*. Pretty simple really.

And moving decompress logic to user space even better.


