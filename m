Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272686AbTHENTA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272755AbTHENS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:18:59 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:32714 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S272686AbTHENSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:18:38 -0400
Message-ID: <3F2FB307.2000901@genebrew.com>
Date: Tue, 05 Aug 2003 09:37:11 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Schubert <bernd-schubert@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interactive Usage of 2.6.0.test1 worse than 2.4.21
References: <200308050704.22684.martin.konold@erfrakon.de> <200308051452.02417.bernd-schubert@web.de>
In-Reply-To: <200308051452.02417.bernd-schubert@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If disk is involved, your problem might simply be the incorrect 
readahead value. Try "hdparm -a 512".

http://marc.theaimsgroup.com/?l=linux-kernel&m=105830624016066&w=2

-Rahul
-- 
Rahul Karnik
rahul@genebrew.com

