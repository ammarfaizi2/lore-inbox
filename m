Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbUK1LwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbUK1LwU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 06:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbUK1LwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 06:52:20 -0500
Received: from quechua.inka.de ([193.197.184.2]:53455 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261441AbUK1LwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 06:52:18 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20041128105646.GD22793@wiggy.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CYNbE-0006eF-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 28 Nov 2004 12:52:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041128105646.GD22793@wiggy.net> you wrote:
> Previously Bernd Eckenfels wrote:
>> The syscall should also allow cunking in response, unless we remove all
>> high-volumne answers from it.
> 
> Are we reinventing netlink?

Yes, meybe high volumne stuff via netlink and parameters via sysctl
interface. Hmm NETLINK on file FDs? :)

Greetings
Bernd
