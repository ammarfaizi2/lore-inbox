Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263391AbUJ2PiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263391AbUJ2PiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbUJ2Pgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:36:55 -0400
Received: from ranger.systems.pipex.net ([62.241.162.32]:22943 "EHLO
	ranger.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263400AbUJ2PHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:07:43 -0400
Date: Fri, 29 Oct 2004 16:08:59 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@ezer.homenet
To: linux-kernel@vger.kernel.org
Subject: Latest Microcode data from Intel now available.
Message-ID: <Pine.LNX.4.61.0410281531370.2379@ezer.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The latest (12 Oct 2004) microcode update data file for Intel processors 
(x86 and x86_64) is now available from the usual place:

http://urbanmyth.org/microcode/

Also note that the microcode_ctl utility has been changed in the latest
tar.gz file to NOT do the ioctl ("-i" option) which is no longer supported 
by the driver. So, if your startup scripts still invoke it with "-i" 
please update them accordingly.

Kind regards
Tigran
