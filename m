Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVEZSnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVEZSnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVEZSnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:43:07 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:10470 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S261689AbVEZSnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:43:04 -0400
Message-ID: <200505261843.j4QIh0fX002244@StraightRunning.com>
Date: Thu, 26 May 2005 19:42:59 +0100
From: Colin Harrison <colin.harrison@virgin.net>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1 alsa oops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Copyright: Copyright (c) 2005 Colin Harrison
X-Domain: StraightRunning.com
X-Admin: colin@straightrunning.com
X-Originating-Heisenberg-IP: [62.3.107.196]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reckon avoiding-mmap-fragmentation-fix-2.patch is the one to back out.
