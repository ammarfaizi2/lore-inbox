Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVAKUAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVAKUAM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVAKT7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:59:51 -0500
Received: from quechua.inka.de ([193.197.184.2]:56238 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262383AbVAKT70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:59:26 -0500
From: Bernd Eckenfels <ecki-news2004-12@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Organization: Deban GNU/Linux Homesite
In-Reply-To: <41E40E9D.9090502@comcast.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CoSAi-0005Ik-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 11 Jan 2005 20:59:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <41E40E9D.9090502@comcast.net> you wrote:
> A few bugfix backports may be fine, though that's already light to fair
> work (depending on how many security bugs are being found and need
> backporting, versus how many can patch clean without porting); How do
> you people maintain 4 ACTIVE branches?

Because those people are many, and as long as there are volunteers to
maintain a branch, nobody can stop them from doing so.

BTW: I generally agree with you, that adding features should be limited.
However stuff like new drivers or subsystems which have their own lifecylce
and small impact are added to stable just because the innovations are needed
by the users (most often because of new hardware or generally more
stability or performance)

Bernd
