Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTG1LYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTG1LYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:24:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12425
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263398AbTG1LX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:23:27 -0400
Subject: Re: PATCH: keyboard controller by default if not embedded
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20030728081545.C1707@infradead.org>
References: <200307272004.h6RK49Ae029610@hraefn.swansea.linux.org.uk>
	 <20030728081545.C1707@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059392089.15438.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jul 2003 12:34:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-28 at 08:15, Christoph Hellwig wrote:
> Again this is crap and make no sense for most x86 subarches except
> X86_PC.  And means useless bloat for all my modwern PeeCees with USB
> keyboard and mouse.

USB isnt the default yet and it stops a zillion people reporting 2.6.0-test
doesn't work or hangs on boot as they are now. 


