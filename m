Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVAaKvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVAaKvC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 05:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVAaKvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 05:51:02 -0500
Received: from smtpout16.mailhost.ntl.com ([212.250.162.16]:4197 "EHLO
	mta08-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261850AbVAaKud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 05:50:33 -0500
Message-ID: <41FE0D75.7080707@smallworld.cx>
Date: Mon, 31 Jan 2005 10:50:29 +0000
From: Ian Leonard <ian@smallworld.cx>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unexpected reboots on high IDE access
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a number of Nova Eden 733 motherboards with the
VIA VT82C686 chipsets.

They will all reboot (not hang, actually reboot) after a random period 
of several hours. This seems to be linked with running an application 
with a lot of disk access.

The kernel is 2.4.27-pre1. Does anyone know of any problems that might 
cause this?

Thanks.

-- 
Ian Leonard

Please ignore spelling and punctuation - I did.
