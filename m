Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269886AbTGOX4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269895AbTGOX4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:56:55 -0400
Received: from smtp2.brturbo.com ([200.199.201.30]:26507 "EHLO
	smtp.brturbo.com") by vger.kernel.org with ESMTP id S269886AbTGOX4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:56:54 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.0-test1: include/linux/pci.h inconsistency?
Date: Tue, 15 Jul 2003 20:59:31 -0300
User-Agent: KMail/1.5.9
Cc: Lars Duesing <ld@stud.fh-muenchen.de>, linux-kernel@vger.kernel.org
References: <1058195165.4131.6.camel@ws1.intern.stud.fh-muenchen.de> <200307151027.06474.eu@marcelopenna.org> <20030715144212.GB13207@gtf.org>
In-Reply-To: <20030715144212.GB13207@gtf.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307152059.31746.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

I tried adding the PCI ids from the nvnet "source" to amd8111e.c, but it 
didn't work. I didn't do any debugging. I'll try with pcnet32 now to see what 
happens and do some debugging later.

Thank you for the tip,

Marcelo Penna Guerra

On Tuesday 15 July 2003 11:42, Jeff Garzik wrote:
> On Tue, Jul 15, 2003 at 10:27:06AM -0300, Marcelo Penna Guerra wrote:
> I really would love some person with an nForce NIC to try and use
> amd8111e.c or pcnet32.c with their nForce2 NIC, and see what happens.
>
> (you would need to add PCI ids, obviously, and perhaps turn on debugging
> to see what happens)
>
> 	Jeff
