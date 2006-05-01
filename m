Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWEAV4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWEAV4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWEAV4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:56:52 -0400
Received: from ntwklan-62-233-162-146.devs.futuro.pl ([62.233.162.146]:42449
	"EHLO mail.softwaremind.pl") by vger.kernel.org with ESMTP
	id S932289AbWEAV4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:56:51 -0400
From: Marcin Hlybin <marcin.hlybin@swmind.com>
To: linux-kernel@vger.kernel.org
Subject: Open Discussion, kernel in production environment
Date: Mon, 1 May 2006 23:57:48 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605012357.48623.marcin.hlybin@swmind.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I always configure and compile a kernel throwing out all unusable options and 
I never use modules in production environment (especially for the router). 
But my superior has got the other opinion - he claims that distribution 
kernel is quite good and in these days optimization has no sense because of 
powerful hadrware. 
What do you think? I have few arguments for this discussion but I wonder what 
you say. Please, try to substantiate your opinions.

And the second question: which kernel branch/version *and why* do you use in 
production environment?

Regards

-- 
 Marcin Hlybin, marcin.hlybin@swmind.com
 Sys/Net Administrator, tel. +48 12 2523 402
