Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266177AbUFYDEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbUFYDEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 23:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUFYDEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 23:04:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:14477 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266177AbUFYDEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 23:04:11 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
Organization: Deban GNU/Linux Homesite
In-Reply-To: <001901c459cd$bc436e40$868209ca@home>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Bdh0b-0004N4-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 25 Jun 2004 05:04:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <001901c459cd$bc436e40$868209ca@home> you wrote:
> The point to note here is that we are not bothering how much quota has been
> allocated to an individual user by the admin, but we are more interested in
> the usage pattern followed by the users. E.g. if user B wants additional
> space of say 25 megs, he picks up 25 megs of his files and 'marks' them
> elastic. Now his quota is increased to 125 megs and he can now add more 25
> megs of files; at the same time allocated quota for user A is left
> unaffected.

I would better understand if you do not incease the quota, but simply dont
count the elastic files in the consumption.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
