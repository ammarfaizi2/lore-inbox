Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWJDVMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWJDVMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWJDVMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:12:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2792 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751124AbWJDVME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:12:04 -0400
Subject: Re: Industrial device driver uio/uio_*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <1159990345.1386.277.camel@localhost.localdomain>
References: <1157995334.23085.188.camel@localhost.localdomain>
	 <1159988394.25772.97.camel@localhost.localdomain>
	 <20061004121835.bb155afe.akpm@osdl.org>
	 <1159990345.1386.277.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 22:37:20 +0100
Message-Id: <1159997840.25772.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-04 am 21:32 +0200, ysgrifennodd Thomas Gleixner:
> I have no objections, if you pull it from -mm for now. The list of flaws
> is accepted and we'll work on this in foreseeable time, _IF_ there is
> some basic consensus about the idea itself not being fundamentaly wrong.

The device stuff seems ok, the class stuff seems to me overconvoluted
but I'd rather someone who knew the class stuff well (Greg thats you)
made that decision.

Alan

