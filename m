Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUGZCMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUGZCMq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 22:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGZCMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 22:12:46 -0400
Received: from quechua.inka.de ([193.197.184.2]:57506 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264826AbUGZCMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 22:12:45 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200407261138.55020.ben@jeeves.gotdns.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Bouyq-0001OQ-00@calista.eckenfels.6bone.ka-ip.net>
Date: Mon, 26 Jul 2004 04:12:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200407261138.55020.ben@jeeves.gotdns.org> you wrote:
> I think the idea of forking off certain releases in the 2.6.x.0 form, to only 
> recieve bugfixes and security updates, is a very good idea.

Leave that to the vendors, they already do that.

Whats wrong with adding features which touch major parts of the code only to
2.7, and perhaps bacport them if they proof to be worth it?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
