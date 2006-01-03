Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWACCye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWACCye (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 21:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWACCye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 21:54:34 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:25224 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750808AbWACCye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 21:54:34 -0500
Date: Mon, 02 Jan 2006 21:54:23 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: New squawk in logwatch report?
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200601022154.23484.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Running 2.6.15-rc7, uptime 6d 23:43 atm.
Going thru the systems email output, I note this in the logwatch file, 
something I don't recall seeing previously:
 --------------------- Kernel Begin ------------------------ 

WARNING:  Kernel Errors Present
   smb_lookup: find contrib/ircstats2 failed, error=-5...:  1 Time(s)
   smb_proc_readdir_long: error=-2, breaking...:  2 Time(s)
   smb_proc_readdir_long: error=-5, breaking...:  1 Time(s)
   smb_proc_readdir_long: error=-512, breaking...:  1 Time(s)

 ---------------------- Kernel End -------------------------

Does anyone have a clue?  Other than its samba related, I have no clue.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
