Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946653AbWJSXKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946653AbWJSXKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946654AbWJSXKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:10:34 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:12252 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S1946653AbWJSXKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:10:34 -0400
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
	[version 3]
From: Adam Belay <abelay@MIT.EDU>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20061019154128.GD2602@parisc-linux.org>
References: <20061017145146.GJ22289@parisc-linux.org>
	 <20061019154128.GD2602@parisc-linux.org>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 19:13:56 -0400
Message-Id: <1161299636.16080.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.217
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 09:41 -0600, Matthew Wilcox wrote:
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Acked-by: Adam Belay <abelay@novell.com>

It would be nice if we had sysfs expose struct file at some point... :)

Thanks,
Adam


