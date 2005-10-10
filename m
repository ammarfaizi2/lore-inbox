Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVJJMgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVJJMgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 08:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVJJMgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 08:36:37 -0400
Received: from swm.pp.se ([195.54.133.5]:49060 "EHLO uplift.swm.pp.se")
	by vger.kernel.org with ESMTP id S1750770AbVJJMgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 08:36:37 -0400
Date: Mon, 10 Oct 2005 14:36:36 +0200 (CEST)
From: Mikael Abrahamsson <swmike@swm.pp.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
In-Reply-To: <20051010112233.6739.qmail@web30309.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.62.0510101435330.24341@uplift.swm.pp.se>
References: <20051010112233.6739.qmail@web30309.mail.mud.yahoo.com>
Organization: People's Front Against WWW
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2005, subbie subbie wrote:

> Which tool can I use to stress all 12 disks reading many many files in 
> parallel?

Start 400 dd:s ? You will find that you will destroy performance as the 
drive heads will be thrashing a lot.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
