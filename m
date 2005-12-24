Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVLXXnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVLXXnj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 18:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVLXXnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 18:43:39 -0500
Received: from rtr.ca ([64.26.128.89]:60107 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750757AbVLXXnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 18:43:39 -0500
Message-ID: <43ADDD34.9020101@rtr.ca>
Date: Sat, 24 Dec 2005 18:43:48 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc6 - Success with ICH5/SATA + S.M.A.R.T.
References: <Pine.LNX.4.64.0512241830010.2700@p34>
In-Reply-To: <Pine.LNX.4.64.0512241830010.2700@p34>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >smartmontools is going to have to be updated

What for?

Use "smartctl -d ata /dev/sda"

-ml
