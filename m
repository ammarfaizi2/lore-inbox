Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVDXBmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVDXBmG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 21:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVDXBmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 21:42:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:36323 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262223AbVDXBmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 21:42:04 -0400
Date: Sat, 23 Apr 2005 18:37:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: daniel.ritz@gmx.ch
Cc: Peter.B.Baumann@stud.informatik.uni-erlangen.de,
       linux-kernel@vger.kernel.org, greg@kroah.com, jgarzik@pobox.com
Subject: Re: [Bug] invalid mac address after rebooting (2.6.12-rc2-mm2)
Message-Id: <20050423183754.43e4a813.akpm@osdl.org>
In-Reply-To: <200504191947.38500.daniel.ritz@gmx.ch>
References: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de>
	<200504172226.44173.daniel.ritz@gmx.ch>
	<20050418221951.GA18641@faui00o.informatik.uni-erlangen.de>
	<200504191947.38500.daniel.ritz@gmx.ch>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Ritz <daniel.ritz@gmx.ch> wrote:
>
> > > --- 1.77/drivers/net/3c59x.c	2005-03-03 06:00:42 +01:00
>  > > +++ edited/drivers/net/3c59x.c	2005-04-17 22:17:19 +02:00
> ...
>  > The patch solved it. Thank you for your help.
> 
>  ok, nice to see it working. 
>  andrew, could you add it to -mm please?

Sure will.  Thanks for working that out.
