Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUCPWSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUCPWSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:18:50 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:24225 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S261744AbUCPWSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:18:48 -0500
Subject: Re: The verdict on the future of suspending to disk?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>
In-Reply-To: <20040316113717.GB2282@elf.ucw.cz>
References: <1079408330.3403.5.camel@calvin.wpcb.org.au>
	 <20040316113717.GB2282@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1079467995.3403.68.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Wed, 17 Mar 2004 09:13:15 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-03-17 at 00:37, Pavel Machek wrote:
> I do not think Patrick is going to maintain anything.
> 
> If you want to maintain it, you can have it. Big plus if you are able
> to deal with Patrick.

Okay, but can we clearly delineate responsibilities? I'm happy to deal
with the suspend-to-disk stuff because I understand it. I don't however
understand suspend-to-ram or kobjects (yes, I will need to learn them)
or device drivers, so I don't want anyone thinking I'm going to
concentrate on anything more than what I'm already doing. That said, I'd
love to take over software suspend and work on merging the work I've
done.

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

