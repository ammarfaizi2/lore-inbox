Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbTEOTqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbTEOTqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:46:32 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:42887 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S264183AbTEOTqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:46:31 -0400
Message-ID: <3EC3F186.1030304@cox.net>
Date: Thu, 15 May 2003 15:59:02 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.5.69-bk10] kudzu finds PS/2 mouse when none exist
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a PS/2 wheel mouse on my system, but kudzu finds one when I 
boot 2.5.69-bk*. I have a USB Wheel mouse attached though. I'm wondering 
if this may be the cause of the issue with some USB mice and trackballs 
not working when ACPI is loaded without pci=noacpi.

Comments would be appreciated.

Thanks,
David

