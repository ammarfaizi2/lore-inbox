Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWBSULG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWBSULG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 15:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWBSULG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 15:11:06 -0500
Received: from mailhub247.itcs.purdue.edu ([128.210.5.247]:29912 "EHLO
	mailhub247.itcs.purdue.edu") by vger.kernel.org with ESMTP
	id S1750979AbWBSULF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 15:11:05 -0500
Message-ID: <43F8D0D6.2080603@purdue.edu>
Date: Sun, 19 Feb 2006 15:11:02 -0500
From: Chase Douglas <cndougla@purdue.edu>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Determine Files or Blocks in Page Cache
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
X-PerlMx-Virus-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm doing some research with servers and would like to know if there's 
any reasonable way to determine which files or blocks of files are being 
cached at any given time. If there isn't a way right now, how feasible 
would it be to hack a module to create an interface for this.

Thank you,
Chase Douglas
