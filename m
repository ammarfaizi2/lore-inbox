Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVGLSRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVGLSRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVGLSRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:17:55 -0400
Received: from mail0.lsil.com ([147.145.40.20]:1203 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261993AbVGLSRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:17:17 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C030A9D9C@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: James Bottomley <James.Bottomley@SteelEye.com>, bharata@in.ibm.com
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Wade, Roy" <Roy.Wade@lsil.com>
Subject: RE: [BUG] Fusion MPT Base Driver initialization failure with kdum
	p
Date: Tue, 12 Jul 2005 12:15:38 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen the report. I need more info from Bharata on how
to reproduce. Perhaps you can send me email offline which
provides specific instructions to how to configure kdump,
how to capture the dump, and what you did to crash your system.

Eric Moore
LSI Logic Corporation

On Tuesday, July 12, 2005 10:23 AM, James Bottomley wrote:
> 
> 
> On Tue, 2005-07-12 at 11:26 +0530, Bharata B Rao wrote:
> > Fusion MPT base driver fails during initialization when 
> kdump capture
> > kernel boots. The details of the problem are reported here:
> 
> This bug report is pretty useless to me because I do a lot of my email
> when I'm offline, so I can't get to the bugzilla report and you supply
> no other details.
> 
> Also, we've invested quite a bit of effort persuading IBM to alter the
> kernel bugzilla to collect email replies into the bug report, 
> so if you
> wish to bother the email list it should be
> 
> 1. With the full bug report that allows people actually to assess the
> problem
> 2. cc'd to the correct bugzilla address so that bugzilla 
> itself collects
> any replies and suggestions.
> 
> James
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
