Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTFXQtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTFXQtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:49:46 -0400
Received: from msgbas1tx.cos.agilent.com ([192.25.240.37]:13524 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S262439AbTFXQtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:49:41 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D551CB@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: sam@ravnborg.org, yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux-2.5.71 kernel compile error
Date: Tue, 24 Jun 2003 11:03:47 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sam!

> -----Original Message-----
> From: Sam Ravnborg [mailto:sam@ravnborg.org]
> Sent: Monday, June 23, 2003 1:09 PM
> To: yiding_wang@agilent.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Linux-2.5.71 kernel compile error
> 
> 
> On Fri, Jun 20, 2003 at 04:05:12PM -0600, 
> yiding_wang@agilent.com wrote:
> > Team,
> > 
> > I got failure on compiling the kernel in one of SuperMicro 
> signle CPU system.  It has a Linux 2.4.2 on it.  
> > The message is "Unknown Pseudo-op:  '.incbin'"
> 
> As per Documentation/Changes ld -v shall say at least: 2.12
> 
> You need to upgrade your binutils.
> 
> 	Sam
> 
