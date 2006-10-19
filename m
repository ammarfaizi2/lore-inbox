Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946203AbWJSQcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946203AbWJSQcs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946205AbWJSQcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:32:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5782 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946203AbWJSQcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:32:47 -0400
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
	[version 3]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Adam Belay <abelay@MIT.EDU>
In-Reply-To: <20061019154128.GD2602@parisc-linux.org>
References: <20061017145146.GJ22289@parisc-linux.org>
	 <20061019154128.GD2602@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 17:32:09 +0100
Message-Id: <1161275529.17335.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 09:41 -0600, ysgrifennodd Matthew Wilcox:
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> 

Acked-by: Alan Cox <alan@redhat.com>

Add a note to the block call that anyone blocking it for long times will
be unpopular.


