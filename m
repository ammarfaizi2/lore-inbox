Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTGRMuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTGRMuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:50:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11475
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262872AbTGRMuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:50:19 -0400
Subject: Re: Linux 2.4.22-pre6-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030718131714.A26615@infradead.org>
References: <200307181212.h6ICCQ925343@devserv.devel.redhat.com>
	 <20030718131714.A26615@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058533363.19512.39.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 14:02:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-18 at 13:17, Christoph Hellwig wrote:
> On Fri, Jul 18, 2003 at 08:12:26AM -0400, Alan Cox wrote:
> > o	The tty procfile can reveal keycounts make	(Solar Designer)
> > 	it root only
> 
> Shouldn't we just kill it completly?

It is useful in lots of situations, its just *too* useful in some of
them. I don't see a reason to kill it off

