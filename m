Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUJaTef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUJaTef (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 14:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbUJaTef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 14:34:35 -0500
Received: from quechua.inka.de ([193.197.184.2]:49386 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261638AbUJaTee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 14:34:34 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Raid1 DM vs MD
Organization: Deban GNU/Linux Homesite
In-Reply-To: <Pine.LNX.4.61.0410311902300.1819@merlin.sk-tech.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1COLTE-0003TV-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 31 Oct 2004 20:34:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.61.0410311902300.1819@merlin.sk-tech.net> you wrote:
> I had one MD-Raid1 where a good copy of the mirror was overwritten by the 
> bad (old) copy ... I lost 3 Month worth of data and I am expecting loosing 
> a linux project and in the worst case - even a court case :(

This is the expected behaviour in  your situation.

I mean, if you dont do backup for month something has to go wrong :)

But more seriouly, when did that overwrite happen? After reboot or have you
changed media? Was the data lost because of corruption or because the old
copy did not contained the data?

Bernd
