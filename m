Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVBCIvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVBCIvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVBCIvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:51:14 -0500
Received: from web52305.mail.yahoo.com ([206.190.39.100]:23484 "HELO
	web52305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262898AbVBCIu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:50:28 -0500
Message-ID: <20050203085027.66880.qmail@web52305.mail.yahoo.com>
Date: Thu, 3 Feb 2005 09:50:27 +0100 (CET)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: ppc32 MMCR0_PMXE saga.
To: Dave Jones <davej@redhat.com>, tglx@linutronix.de, akpm@osdl.org,
       torvalds@osdl.org, dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050203044702.GA1089@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Dave Jones <davej@redhat.com> escribió: 
> I'm at a loss to explain whats been happening with
> this symbol.

My patch was against the -mm series, as reported in
the original subject.

In the -mm series, the perfctr-ppc.patch already
defines that symbol. As that patch contains all the
perfctr related bits, it made sense to remove the
definition coming from the Linus tree and keep the
definition from the perfctr-ppc.patch. But just on
-mm.

Cheers,
Albert



		
______________________________________________ 
Renovamos el Correo Yahoo!: ¡250 MB GRATIS! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
