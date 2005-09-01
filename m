Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVIAAgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVIAAgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 20:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVIAAgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 20:36:13 -0400
Received: from quechua.inka.de ([193.197.184.2]:15799 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S965004AbVIAAgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 20:36:12 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <43163430.7010107@utah-nac.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1EAd3q-0007DH-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 01 Sep 2005 02:36:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <43163430.7010107@utah-nac.org> you wrote:
> I disagree with the language and the characterization that our 
> proprietary user application code is "tainted."

The kernel is tainted if you install non-open source modules. You are not
allowed to circumvent this mechanism if you want to ship binary only
modules.

Gruss
Bernd
