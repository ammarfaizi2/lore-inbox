Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271269AbTGWW1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271358AbTGWW1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:27:30 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:3823 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271269AbTGWW10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:27:26 -0400
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Bernardo Innocenti <bernie@develer.com>, Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030723222747.GF643@alpha.home.local>
References: <200307232046.46990.bernie@develer.com>
	 <20030723193246.GA836@lst.de> <200307232357.25128.bernie@develer.com>
	 <200307240007.15377.bernie@develer.com>
	 <20030723222747.GF643@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058999665.6890.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 23:34:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 23:27, Willy Tarreau wrote:
> I was interested in using a very minimal pre-boot kernel with kexec which would
> automatically select a valid image among several ones. But 500 kB overhead for
> a boot loader quickly refrained me...

Something like the GPL'd eCos might be a better option (or on x86 there
is the 64K Linux 8086)

