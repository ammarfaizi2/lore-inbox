Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVBWU7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVBWU7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVBWU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:59:15 -0500
Received: from mx1.mail.ru ([194.67.23.121]:65081 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261581AbVBWU5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:57:25 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [BK PATCHES] 2.6.x libata fixes (mostly)
Date: Wed, 23 Feb 2005 23:57:18 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mark Lord <mlord@pobox.com>
References: <421CE018.5030007@pobox.com> <200502232345.23666.adobriyan@mail.ru>
In-Reply-To: <200502232345.23666.adobriyan@mail.ru>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200502232357.18723.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 February 2005 23:45, Alexey Dobriyan wrote:
> > +static void qs_ata_setup_port(struct ata_ioports *port, unsigned long base)
> > +{
> > +	port->cmd_addr		=
> 
> > +	port->error_addr	=
> 
> > +	port->status_addr	=
> 
> > +	port->altstatus_addr	=
> 
> Oo-oops...

Too much snipping and time to sleep for me, sorry. :-(

	Alexey
