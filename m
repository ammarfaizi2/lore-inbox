Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWC3Vtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWC3Vtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWC3Vtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:49:53 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:21724 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751002AbWC3Vtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:49:52 -0500
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <26F95EDB-C8BA-4FF0-A847-10D6D4255C4C@kernel.crashing.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: kconfig question
Date: Thu, 30 Mar 2006 15:50:04 -0600
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

Is there a way to have a set of choices either be mutual exclusive or  
individually selectable depending on how some other Kconfig var is set?

- kumar
