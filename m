Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUHASwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUHASwq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 14:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUHASwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 14:52:46 -0400
Received: from quechua.inka.de ([193.197.184.2]:13744 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266115AbUHASwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 14:52:45 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Organization: Deban GNU/Linux Homesite
In-Reply-To: <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BrLRs-0007yu-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 01 Aug 2004 20:52:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com> you wrote:
> How hard would it be to have a per-task bitmap of syscalls allowed? This
> way, a task could restrict to the exact subset of syscalls required for
> maximum security.

Which somewhat overlaps with the user-priveldeges patches and some lsm
modules, so i am not sure if this needs to be small and lean to be useful on
its own.

Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
