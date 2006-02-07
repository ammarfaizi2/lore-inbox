Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWBGK2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWBGK2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 05:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWBGK2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 05:28:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:29684 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964839AbWBGK2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 05:28:22 -0500
From: Alexander Nassian <linux@picadreams.com>
Reply-To: linux@picadreams.com
Organization: Picadreams
To: linux-kernel@vger.kernel.org
Subject: Development of Ricoh Memory Host Adapter
Date: Tue, 7 Feb 2006 11:28:16 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071128.16673.linux@picadreams.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:47a97636800c7dec849c35c16a88e2b4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm new to kernel programming and wanted to try to develop my first "real" 
kernel module. Up to now I only programmed little, useless, modules to get 
into the kernel.

Because there is no module for the Ricoh Memory Host Adapter, which is in my 
notebook, I want to start developing one.
00:0a.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 
17)

The problem is, that I have absolutely no idea where to start. When I'm 
looking at the code of existing MMC modules, I wanna start cry.

Do you have any tips, tutorials, ... how I can start, step by step, the 
development of this module?

Sincereley,
Alexander Nassian
