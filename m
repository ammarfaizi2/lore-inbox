Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUCLItl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUCLItl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:49:41 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:31752 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262043AbUCLItj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:49:39 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
Date: Thu, 11 Mar 2004 18:25:22 +0100
User-Agent: KMail/1.6.1
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-mm@kvack.org,
       Mike Fedyk <mfedyk@matchmail.com>, plate@gmx.tm
References: <404FACF4.3030601@cyberone.com.au>
In-Reply-To: <404FACF4.3030601@cyberone.com.au>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403111825.22674@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 01:04, Nick Piggin wrote:

Hi Nick,

> Here is my updated patches rolled into one.

hmm, using this in 2.6.4-rc2-mm1 my machine starts to swap very very soon. 
Machine has squid, bind, apache running, X 4.3.0, Windowmaker, so nothing 
special.

Swap grows very easily starting to untar'gunzip a kernel tree. About + 
150-200MB goes to swap. Everything is very smooth though, but I just wondered 
because w/o your patches swap isn't used at all, even after some days of 
uptime.

ciao, Marc

