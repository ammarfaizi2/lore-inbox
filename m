Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWFURJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWFURJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWFURJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:09:37 -0400
Received: from web36404.mail.mud.yahoo.com ([209.191.85.139]:6052 "HELO
	web36404.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932268AbWFURJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:09:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RI38rr9qHzHlXJU7Tc1UEkH3SIKlo3xlWTY6YYKLA2SZpSm03dS89hOLueU/VOpWVpJaRlHR/nVUJ0v/UgpffvHkJ/frfrNDpet1LNPlbnskGHvj0aKjPqRBFhJfsUqCVBroHLYCJj0A6kDYEDkaVcQwG9Jcg8g17vGTvnZDBAo=  ;
Message-ID: <20060621170936.50240.qmail@web36404.mail.mud.yahoo.com>
Date: Wed, 21 Jun 2006 10:09:36 -0700 (PDT)
From: Dennis Jacob <dennis_jacob_78@yahoo.com>
Subject: Unable to load kernel to intel ixp
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello There,

   I am trying to load Montavista linux to intel
ixp425. The board comes with redboot on it.

The redboot itself shows the following error before
its prompt comes up.
[error] ixEthMiiPhyScan : unexpected Mii PHY ID
03026071

Anyway, I am able to load zImage and ramdisk to
0x01600000 and 0x00800000 respectively. But when I
give "go 0x01600000", kernel starts
"Uncompressing....". But, in the middle one message
comes like "Unable to handle kernel paging request at 
virtual address 40afb000 mm = c01e1380 pgd =
c0004000".

Has anyone encountered the same problem?
Please help me.

Thanks 
Dennis


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
