Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264775AbUFLNo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbUFLNo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbUFLNo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:44:29 -0400
Received: from nepa.nlc.no ([195.159.31.6]:52924 "HELO nepa.nlc.no")
	by vger.kernel.org with SMTP id S264775AbUFLNo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:44:28 -0400
Message-ID: <1439.83.109.11.80.1087047858.squirrel@nepa.nlc.no>
Date: Sat, 12 Jun 2004 15:44:18 +0200 (CEST)
Subject: Re: new kernel bug
From: stian@nixia.no
To: linux-kernel@vger.kernel.org
Cc: "David Connolly" <slarti@netsoc.dkit.ie>
User-Agent: SquirrelMail/1.4.0-1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try the patch that lies in this mail?
http://marc.theaimsgroup.com/?l=linux-kernel&m=108704705509728&w=2

I posted the bug orignaly in that thread since I didn't know much about it
yet (and it's not a race, but the kernel get stuck in a exception loop
beetween the program an the kernel while trying to make the SIGFPE)


Stian Skjelstad
