Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVA0XBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVA0XBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVA0XBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:01:18 -0500
Received: from web52306.mail.yahoo.com ([206.190.39.101]:38572 "HELO
	web52306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261290AbVA0XAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:00:08 -0500
Message-ID: <20050127230002.12222.qmail@web52306.mail.yahoo.com>
Date: Fri, 28 Jan 2005 00:00:02 +0100 (CET)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: 2.6.11-rc2-mm1: kernel bad access while booting diskless client
To: Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1106866256.7616.50.camel@winden.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Andreas Gruenbacher <agruen@suse.de> escribió: 
> Hello,
> 
> here is a fix for a NULL pointer access problem with
> NFSv2 that isn't in
> 2.6.11-rc2-mm1, but it can't explain this NULL
> inode->i_op.
> 
> -- Andreas.

Hi,

Yes, that patch seems unrelated.
Same Oops with or without it.

Thanks,
Albert



		
______________________________________________ 
Renovamos el Correo Yahoo!: ¡250 MB GRATIS! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
