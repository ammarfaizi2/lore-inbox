Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUBTQC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 11:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbUBTQC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 11:02:26 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:25446 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S261303AbUBTQCY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 11:02:24 -0500
Date: Fri, 20 Feb 2004 17:02:00 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
cc: Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: 2.4.25 Ooops & crash
Message-ID: <Pine.LNX.4.58LT.0402201652320.2690@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have unlucky with latest 2.4.25 kernel. Most of my machines after 
upgrade kernel to 2.4.25 (from 2.4.24) automatically restart after several 
hours, or Ooops (swapper proces, pid 0).
In logs file i haven't any information from kernel (oops and other strange 
thing). Unfortunately i can't connect serial console to catch information 
from console. :(
With 2.4.24 or earlier i had uptime about 50-100 days (except one machine)
I don't see any reports about this problem on this list, strange.

On http://lukasz.eu.org/2.4.25-rc1 you can see ksymoops.txt or vmlinux
from machine where i tested 2.4.25-rc1.


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
