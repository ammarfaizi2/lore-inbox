Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVCLBSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVCLBSg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 20:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVCLBSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 20:18:36 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:46352 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261821AbVCLBRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 20:17:47 -0500
Message-Id: <200503120346.j2C3j9Jp006543@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Export gcov symbol based on gcc version 
In-Reply-To: Your message of "Sat, 12 Mar 2005 00:37:22 +0100."
             <20050311233722.GS3723@stusta.de> 
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org> <20050310225340.GD3205@stusta.de> <200503111849.j2BImsJp003370@ccure.user-mode-linux.org> <20050311165526.GA3723@stusta.de> <200503112354.j2BNrFJp005237@ccure.user-mode-linux.org>  <20050311233722.GS3723@stusta.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Mar 2005 22:45:09 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bunk@stusta.de said:
> No, my claim is that no sane gcc 3.3 defines __gcov_init. 

Ah, OK.  Thanks for the clarification.

				Jeff

