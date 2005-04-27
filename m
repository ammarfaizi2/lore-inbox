Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVD0Rfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVD0Rfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVD0Rfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:35:40 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:61893 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261835AbVD0Rf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:35:28 -0400
Subject: Re: [01/07] uml: add nfsd syscall when nfsd is modular
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org
In-Reply-To: <20050427171552.GB3195@kroah.com>
References: <20050427171446.GA3195@kroah.com>
	 <20050427171552.GB3195@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114619612.18355.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Apr 2005 17:33:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-04-27 at 18:15, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.

Don't see why this one is a critical bug.


