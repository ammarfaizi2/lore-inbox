Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbTAPRhF>; Thu, 16 Jan 2003 12:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbTAPRhF>; Thu, 16 Jan 2003 12:37:05 -0500
Received: from host194.steeleye.com ([66.206.164.34]:19472 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267122AbTAPRhF>; Thu, 16 Jan 2003 12:37:05 -0500
Message-Id: <200301161745.h0GHjjf03917@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PARISC] kernel 2.5.58 doesn't compile
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Jan 2003 12:45:44 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vanilla linux kernel doesn't compile for PA-RISC.  This is because, like 
most non-x86 archs, development is done in a source repository stored 
elsewhere and sync'd with the main trunk at appropriate times.

You need the patches from

http://ftp.parisc-linux.org/2.5/kernel-src/

There's also FAQs and Mailing lists appropriate to PA-RISC at

http://www.parisc-linux.org

James


