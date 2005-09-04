Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVIDDs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVIDDs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 23:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVIDDs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 23:48:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:24987 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750836AbVIDDs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 23:48:26 -0400
Subject: Re: RFC: i386: kill !4KSTACKS
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <20050902003915.GI3657@stusta.de>
References: <20050902003915.GI3657@stusta.de>
Content-Type: text/plain
Date: Sat, 03 Sep 2005 23:48:24 -0400
Message-Id: <1125805704.14032.71.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 02:39 +0200, Adrian Bunk wrote:
> 4Kb kernel stacks are the future on i386, and it seems the problems it
> initially caused are now sorted out.
> 
> Does anyone knows about any currently unsolved problems?

ndiswrapper

