Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVKUW1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVKUW1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKUW1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:27:39 -0500
Received: from mail.linspire.com ([130.94.123.204]:16611 "EHLO
	mail.lindows.com") by vger.kernel.org with ESMTP id S1751171AbVKUW1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:27:38 -0500
Message-ID: <438249CB.8050200@linspire.com>
Date: Mon, 21 Nov 2005 14:27:23 -0800
From: David Fox <david.fox@linspire.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20050922 Linspire/1.6-5.1.1.50.linspire0.2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc2 pci_ids.h cleanup is a pain
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure I'm not the only person that applies patches to the kernel that 
use some of the 500 plus PCI IDS eliminated from pci_ids.h by rc2.  I 
would like to see the PCI ids that were removed simply because the don't 
occur in the main kernel source restored.  Is there a rationale for 
removing them that I'm not aware of?

