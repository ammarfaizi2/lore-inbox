Return-Path: <linux-kernel-owner+w=401wt.eu-S936422AbWLKPXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936422AbWLKPXH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936424AbWLKPXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:23:07 -0500
Received: from plusavs02.SBG.AC.AT ([141.201.10.77]:48881 "HELO
	plusavs02.sbg.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S936422AbWLKPXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:23:06 -0500
Subject: get device from file struct
From: Silviu Craciunas <silviu.craciunas@sbg.ac.at>
Reply-To: silviu.craciunas@sbg.ac.at
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 11 Dec 2006 16:22:28 +0100
Message-Id: <1165850548.30185.18.camel@ThinkPadCK6>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2006 15:22:56.0247 (UTC) FILETIME=[3BD3F870:01C71D38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

quick question for the gurus.. is it possible to determine the hardware
device from a file struct during read/write system call. For example in
fs/read_write.c when doing a vfs_read.  

thanks

