Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288921AbSBEFs3>; Tue, 5 Feb 2002 00:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSBEFsI>; Tue, 5 Feb 2002 00:48:08 -0500
Received: from [65.169.83.229] ([65.169.83.229]:31360 "EHLO
	hst000004380um.kincannon.olemiss.edu") by vger.kernel.org with ESMTP
	id <S288342AbSBEFsD>; Tue, 5 Feb 2002 00:48:03 -0500
Date: Mon, 4 Feb 2002 23:47:09 -0600
From: Benjamin Pharr <ben@benpharr.com>
To: linux-kernel@vger.kernel.org
Subject: choice Help Sections
Message-ID: <20020205054709.GA3245@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.18-pre8
X-PGP-ID: 0x6859792C
X-PGP-Key: http://www.benpharr.com/public_key.asc
X-PGP-Fingerprint: 7BF0 E432 3365 C1FC E0E3  0BE2 44E1 3E1E 6859 792C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone else noticed the availability of only one help section in
"choice" blocks when using make menuconfig (and others maybe?)? 

The best example of this is selection of "Processor family". No matter
which option is highlighted when Help is selected, it always gives the
help for CONFIG_M386.

I thought this was possibly by design until I checked
Documentation/Configure.help and found help sections for the other CPU
families. 

Ben Pharr

