Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbVCDM7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbVCDM7L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVCDM5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:57:09 -0500
Received: from [81.2.110.250] ([81.2.110.250]:45019 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S263050AbVCDMxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:53:24 -0500
Subject: Re: RFD: Kernel release numbering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, jgarzik@pobox.com, torvalds@osdl.org, davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304032820.7e3cb06c.akpm@osdl.org>
References: <42268749.4010504@pobox.com>
	 <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com>
	 <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net>
	 <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com>
	 <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
	 <20050303151752.00527ae7.akpm@osdl.org>
	 <1109894511.21781.73.camel@localhost.localdomain>
	 <20050303182820.46bd07a5.akpm@osdl.org>
	 <1109933804.26799.11.camel@localhost.localdomain>
	 <20050304032820.7e3cb06c.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109940685.26799.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Mar 2005 12:51:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-04 at 11:28, Andrew Morton wrote:
> I think you're assuming that 2.6.x.y will have larger scope than is intended.

The examples I gave for remap_vm_area and exec are both from real world
"gosh look I am root isn't that fun" type security holes. If that is
outside the scope of 2.6.x.y then you need to go back to the drawing
board.

