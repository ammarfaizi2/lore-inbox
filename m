Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTJAOJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTJAOJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:09:46 -0400
Received: from main.gmane.org ([80.91.224.249]:8102 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262109AbTJAOId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:08:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: [ACPI] p2b-ds blacklisted?
Date: Wed, 01 Oct 2003 16:07:36 +0200
Message-ID: <blen4v$a42$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: de, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my P2B-DS is blacklisted and the kernel forced acpi=ht. i wonder why 
because P2B-D is not blacklisted.

There is no comment or any other hint for a reason in dmi_scan.c :-(

I would like to try what happens if i remove the board from the 
blacklist. What can i test to see if it works properly? And what is the 
worse case of what could happen?

Do i have to edit dmi_scan.c for my test or is there something like 
acpi=force?


