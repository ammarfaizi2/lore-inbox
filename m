Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUDBNV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 08:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbUDBNV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 08:21:58 -0500
Received: from zork.zork.net ([64.81.246.102]:9878 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264048AbUDBNVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 08:21:47 -0500
To: Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: disabling SCSI support not possible
References: <406D65FE.9090001@broadnet-mediascape.de>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Apr 2004 14:21:40 +0100
In-Reply-To: <406D65FE.9090001@broadnet-mediascape.de> (Olaf Zaplinski's
 message of "Fri, 02 Apr 2004 15:09:18 +0200")
Message-ID: <6uad1uv7kr.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de> writes:

> I cannot disable SCSI completely in 2.6.4's 'menuconfig'.

I believe that some kernel components require SCSI to be useful and so
force SCSI to be activated.  One example that springs to mind is
usb-storage.

