Return-Path: <linux-kernel-owner+w=401wt.eu-S1751169AbXAFEfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbXAFEfD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 23:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXAFEfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 23:35:03 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:55047 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbXAFEfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 23:35:00 -0500
X-Greylist: delayed 1518 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 23:35:00 EST
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Len Brown <lenb@kernel.org>
Subject: Re: Sony Vaio VGN-SZ340 (was Re: sonypc with Sony Vaio VGN-SZ1VP)
Date: Fri, 5 Jan 2007 21:09:35 -0700
User-Agent: KMail/1.9.5
Cc: MoRpHeUz <morpheuz@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Stelian Pop" <stelian@popies.net>,
       "Mattia Dongili" <malattia@linux.it>,
       "Ismail Donmez" <ismail@pardus.org.tr>,
       "Andrea Gelmini" <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, "Cacy Rodney" <cacy-rodney-cacy@tlen.pl>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <7ce7bf330701050924h47546970w36ed189ed147ddb3@mail.gmail.com> <200701051310.41131.lenb@kernel.org>
In-Reply-To: <200701051310.41131.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701052109.35707.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 January 2007 11:10, Len Brown wrote:
> On Friday 05 January 2007 12:24, MoRpHeUz wrote:
> > > What workaround are you using?
> > 
> >  This one: http://bugzilla.kernel.org/show_bug.cgi?id=7465
> 
> Ah yes, the duplicate MADT issue is clearly a BIOS bug.
> It is possible that we can tweak our Linux workaround for it to be more
> Microsoft Windows Bug Compatbile(TM).

Maybe Windows discovers processors using the namespace rather
than the MADT.
