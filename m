Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264844AbTFQQox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 12:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTFQQox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 12:44:53 -0400
Received: from quechua.inka.de ([193.197.184.2]:34958 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264844AbTFQQow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 12:44:52 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 Floppy Fallback with NFS root ...
In-Reply-To: <20030617151114.GA910@elf.ucw.cz>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19SJn9-0000Cd-00@calista.inka.de>
Date: Tue, 17 Jun 2003 18:58:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030617151114.GA910@elf.ucw.cz> you wrote:
> This might be okay for 2.5.X, but its definitely bad idea for
> 2.4.X. (User visible change without good reason).

there is a good reason, it is security. But maybe the default should be
compatible.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
