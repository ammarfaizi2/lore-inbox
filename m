Return-Path: <linux-kernel-owner+w=401wt.eu-S1752708AbWLXUrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbWLXUrG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 15:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbWLXUrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 15:47:06 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:53287 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752708AbWLXUrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 15:47:05 -0500
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: linux-kernel@vger.kernel.org
Subject: ACPI EC warnings
Date: Sun, 24 Dec 2006 22:47:06 +0200
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612242247.06989.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the recent ACPI merge I get this in dmesg:

ACPI: EC: evaluating _Q60
ACPI: EC: evaluating _Q60
ACPI: EC: evaluating _Q60
[...]

and similar warnings. Also I am not completely sure but sound skips when I get 
this warning. Anyone experiencing the same problem? Also why does ACPI is 
polluting dmesg like this?

Regards,
ismail

-- 
2 + 2 = 5 for very large values of 2
