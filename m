Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269838AbTGKJJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269840AbTGKJJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:09:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42166
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269838AbTGKJJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:09:15 -0400
Subject: Re: RFC:  what's in a stable series?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030710161553.C22512@infradead.org>
References: <3F0CBC08.1060201@pobox.com>
	 <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva>
	 <20030710085338.C28672@infradead.org>
	 <1057835998.8028.6.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.LNX.4.55L.0307100910550.7857@freak.distro.conectiva>
	 <1057840919.8027.19.camel@dhcp22.swansea.linux.org.uk>
	 <20030710161553.C22512@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057915268.8005.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 10:21:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-10 at 16:15, Christoph Hellwig wrote:
> Unfortunately the second one uses the same constants as the old 16bit one
> but different structures so there is no way to support both in a single
> kernel.

Ok that makes a lot more sense

