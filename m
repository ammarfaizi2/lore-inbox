Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752187AbWCCIZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbWCCIZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 03:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbWCCIZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 03:25:03 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:54717 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP
	id S1752177AbWCCIZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 03:25:01 -0500
Message-ID: <043101c63e9c$86e9d710$0200000a@aldipc>
From: "roland" <devzero@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: is there a COW inside the kernel ?
Date: Fri, 3 Mar 2006 09:29:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello !

is there an equivalent of something like

cowloop ( http://www.atconsultancy.nl/cowloop/total.html ) or md based cow 
device ( http://www.cl.cam.ac.uk/users/br260/doc/report.pdf ),

i.e. a feature called "Copy On Write Blockdevice" inside the current or the 
near-future mainline kernel (besides UserModeLinux Arch)?

i'm not sure - i think i remember having read that something like this can 
be probably done , but i don`t remember anymore what it was.

i would find this useful for several purpose, but i don`t want to patch my 
system with 3rd party drivers or "non-standard" stuff -  or even recompile 
the kernel.

can someone help out with some information ?

TIA

roland k.
system engineer 

