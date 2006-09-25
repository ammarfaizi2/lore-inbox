Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWIYLCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWIYLCZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWIYLCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:02:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57036 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751122AbWIYLCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:02:24 -0400
Subject: Re: [PATCH] restore libata build on frv
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <22314.1159181060@warthog.cambridge.redhat.com>
References: <20060924223925.GU29920@ftp.linux.org.uk>
	 <22314.1159181060@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 12:26:08 +0100
Message-Id: <1159183568.11049.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-25 am 11:44 +0100, ysgrifennodd David Howells:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> 
> > +++ b/include/asm-frv/libata-portmap.h
> > @@ -0,0 +1 @@
> > +#include <asm-generic/libata-portmap.h>
> 
> NAK...  These settings are totally meaningless on FRV.

You have no PCI bus ?

