Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVEVQY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVEVQY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 12:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVEVQY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 12:24:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:31171 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261828AbVEVQYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 12:24:55 -0400
Message-ID: <4290B250.7020001@pobox.com>
Date: Sun, 22 May 2005 12:24:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: perth.adelaide@free.fr
CC: linux-kernel@vger.kernel.org
Subject: Re: Dangerous libata Data Corruption Bug (2.4 & 2.6)
References: <1116751180.4290454cf0c02@imp2-q.free.fr>
In-Reply-To: <1116751180.4290454cf0c02@imp2-q.free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perth.adelaide@free.fr wrote:
> I've been setting up software RAID5/6 file servers for the past few month, and I
> came accross a data corruption bug using the libata driver : It's not an easy
> one to find as I need to copy and copy over data to finally have an error
> (usually betwen 150GB to 2TB).
> 
> So far, every server using the libata driver I've setup has this bug

I run this sort of test regularly.  I worry about your motherboard settings.

Also, hardware info would be nice.

	Jeff



