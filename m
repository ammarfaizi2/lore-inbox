Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbUJXFCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbUJXFCH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 01:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUJXFCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 01:02:07 -0400
Received: from quechua.inka.de ([193.197.184.2]:39555 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261363AbUJXFCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 01:02:04 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: The naming wars continue...
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20041024032902.GA19696@citd.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CLaW2-0005k3-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 24 Oct 2004 07:02:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041024032902.GA19696@citd.de> you wrote:
> The directory is a "user-supplied" value.

Actually yes and no. With 10g, the "product" directory contain the (3
digits) version number (unrelated the actual ora home). 

The different positions are well defined according to oracle, releases have
changes in the first 4 positions, where the first is the major product
version, the second is the release, the third are platform independend
features. The base release for 10g was 10.1.0.2, and the first patchset is
10.1.0.3

> My DBA collegues use a default of first 3 numbers without delimiters
> ie: /server/oracle/920

This has a bit changed with 10g.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
