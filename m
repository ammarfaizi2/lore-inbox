Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUHNULy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUHNULy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUHNULy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:11:54 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:21938 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S264923AbUHNULx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:11:53 -0400
Message-ID: <411E71BB.5080603@rtr.ca>
Date: Sat, 14 Aug 2004 16:10:35 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Nicolas BENOIT <nbenoit@tuxfamily.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No DMA Since 2.6.8 Upgrade
References: <1092493521.468.14.camel@brioche.gwened>
In-Reply-To: <1092493521.468.14.camel@brioche.gwened>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most likely the chipset driver for you mobo isn't loaded.

What's in /var/log/messages from startup?
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
