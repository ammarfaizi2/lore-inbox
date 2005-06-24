Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262978AbVFXBS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbVFXBS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbVFXBS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:18:26 -0400
Received: from mail.hypersurf.com ([209.237.0.6]:25872 "EHLO
	mail.hypersurf.com") by vger.kernel.org with ESMTP id S262978AbVFXBSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:18:17 -0400
Message-ID: <42BB5EDE.8070402@hypersurf.com>
Date: Thu, 23 Jun 2005 18:16:14 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i486; en-US; rv:1.7b) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 750GX HID1 sysctl interface
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I have added support to version 2.4.30 of the kernel to control the PLL 
configuration register (HID1) in the IBM PowerPC 750GX via the sysctl 
(and /proc/sys/kernel) mechanism.

	Is there any interest in this? If so, ... uh ... how do I generate the 
patches and submit them?

					kevin
