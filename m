Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVHKPqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVHKPqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVHKPqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:46:32 -0400
Received: from mx1.aub.nl ([213.84.36.140]:4094 "EHLO mx1.aub.nl")
	by vger.kernel.org with ESMTP id S932174AbVHKPqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:46:31 -0400
Message-ID: <42FB72DE.8000703@aub.nl>
Date: Thu, 11 Aug 2005 17:46:38 +0200
From: Bolke de Bruin <bdbruin@aub.nl>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.5 - Compaq Fibre Channel 64-bit/66Mhz HBA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The company I work for is investigating a switch from Windows 2000 to a 
Linux based setup for its databases. Because of a dependancy on a third 
party we need to settle on kernel 2.6.5. Although the database servers 
will be moved to x86_64, we would like stay using our raid array 
(StorageWorks 4100) as it has been quite a tremendous investment for the 
size of our company and it still works.

However it is unclear if the current controller "Compaq Fibre Channel 
64-bit/66Mhz HBA" is actually supported. This controller has been marked 
broken from kernel 2.6.7 and onwards with a "This is too much stack" 
(drivers/scsi/cpqfcTScontrol.c). Any additional documentation I cannot find.

So the basic question is. Does this controller work on kernel 2.6.5?

and if not and someone wants to give some advice, is it possible to 
replace the controller without having to move to a different raid array 
setup or is a fix pretty easy to create?

Kind regards and thanks in advance,

B. de Bruin



