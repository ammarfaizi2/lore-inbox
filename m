Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbTHSWCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTHSWCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:02:05 -0400
Received: from [62.75.136.201] ([62.75.136.201]:4077 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261492AbTHSWAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:00:36 -0400
Message-ID: <3F429E2D.7090306@g-house.de>
Date: Wed, 20 Aug 2003 00:01:17 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030815
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc Oops with 2.6.0-test3
References: <3F40B665.2010407@g-house.de>
In-Reply-To: <3F40B665.2010407@g-house.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i was able to reproduce with a non tainted kernel:

http://christian.go4more.de/parport/parport_oops.txt

on this machine i am only using PLIP sometimes (to connect a very old 
laptop). so, i don't need parport_pc very often. but as it's used for 
printing too, this could be an issue....

Thanks,
Christian.
-- 
BOFH excuse #39:

terrorist activities

