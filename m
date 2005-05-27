Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVE0Vkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVE0Vkd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 17:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVE0Vkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 17:40:33 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:32408 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262609AbVE0Vk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 17:40:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=YgHq9T2g6tdr9/c6Bkqe34UhFgo3NkWlHjfVpQISh3OtrpPzFycvbNER7pzi5xUrnRYIc/gs5pnZz5fkAJPHonTj2gCJqSAXd2kypXE8NAiruvIEVcoR2HtFIhFMxE+eDtCuq0zqTETP+b5m3kXzArwh90soT/gYxyAehHfhZDk=
Message-ID: <429793C8.8090007@gmail.com>
Date: Fri, 27 May 2005 23:40:24 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>
In-Reply-To: <20050526140058.GR1419@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens,

I tried to play with your patch on ICH6R and ICH7R chipset also on
Sil3124R Controller
with 2xSamsung HD160JJ SATAII drives. But the performance gain stay out..
anything special to set to get it working? I used a vanilla-kernel
2.6.12-rc5-git2 for it.

Thanks for assistance/help

Greets
    Michael
