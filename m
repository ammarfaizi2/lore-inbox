Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269090AbRHBTy7>; Thu, 2 Aug 2001 15:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269089AbRHBTyt>; Thu, 2 Aug 2001 15:54:49 -0400
Received: from jffdns02.or.intel.com ([134.134.248.4]:54015 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S269082AbRHBTyi>; Thu, 2 Aug 2001 15:54:38 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE00B@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'ebuddington@wesleyan.edu'" <ebuddington@wesleyan.edu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.7-ac3 panic on boot (acpi?)
Date: Thu, 2 Aug 2001 12:07:01 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Never seen that before.

Please untar a FRESH vanilla 2.4.7, apply the patch, and try that.

Regards -- Andy

> From: Eric Buddington 
> I untarred that into my existing 2.4.7-ac3 tree, ran make dep; make
> clean; make bzImage, and rebooted. I got "Ran out of input data" right
> after the "uncompressing..." message.
> 
> Does this patch need to go against vanilla 2.4.7?
> 
> -Eric
> 
> On Wed, Aug 01, 2001 at 03:33:50PM -0700, Grover, Andrew wrote:
> > Would you mind doing the following:
> > 
> > 1) Try 2.4.7 patched with the latest ACPI debug version from:
> > 
> > 
ftp://download.intel.com/technology/IAPC/acpi/downloads/acpica-linux-debug-2
> 0010717.tar.gz
> 
> ...and send me your dmesg? We can proceed from there. ;-)
> 
> Regards -- Andy
> 
> > From: Eric Buddington 
> > I began to report this bug a couple weeks back, under 
> > 2.4.6-ac3, but left on vacation before
> > capturing and parsing the panic.

