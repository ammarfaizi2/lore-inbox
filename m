Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTEJPQP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTEJPQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:16:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50319
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264363AbTEJPQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:16:14 -0400
Subject: Re: 2.4.21-rc2 IDE Modular non-compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030510102615.GB12431@louise.pinerecords.com>
References: <20030509064035.4C6612C014@lists.samba.org>
	 <20030509075319.A10102@infradead.org>
	 <20030510102615.GB12431@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052577004.16166.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 May 2003 15:30:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-10 at 11:26, Tomas Szepe wrote:
> > [hch@infradead.org]
> > 
> > This is the patch I sent marcelo just after rc1 was released, I gues
> > it will still apply..
> 
> Christoph, for a fully modular IDE (.config snippet included at the
> end of the post) on .21rc2 I need to apply the following patch on top

You can't have CMD640 support modular. The bool is intentional

