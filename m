Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbTFETem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbTFETem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:34:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24972
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264927AbTFETel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:34:41 -0400
Subject: Re: 2.4.21-rc7 AMD64 dpt_i2o fails compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: warren@togami.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <p73wug067qb.fsf@oldwotan.suse.de>
References: <1054789161.3699.67.camel@laptop.suse.lists.linux.kernel>
	 <20030605010841.A29837@devserv.devel.redhat.com.suse.lists.linux.kernel>
	 <1054799692.3699.77.camel@laptop.suse.lists.linux.kernel>
	 <1054808477.15276.0.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel>
	 <p73wug067qb.fsf@oldwotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054842344.15457.43.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 20:45:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-05 at 13:15, Andi Kleen wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > Fixing up dpt_i2o for the new DMA stuff is a major job. Fixing it for
> > 64bit cleanness even more so.
> 
> If the hardware/firmware supports 64bit pointers then at least AMD64
> can work without the PCI DMA API. 

32bit all around as far I as I can tell

