Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTCBWbi>; Sun, 2 Mar 2003 17:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTCBWbh>; Sun, 2 Mar 2003 17:31:37 -0500
Received: from terminus.zytor.com ([63.209.29.3]:49035 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S261857AbTCBWbh>; Sun, 2 Mar 2003 17:31:37 -0500
Message-ID: <3E6288B5.6060000@zytor.com>
Date: Sun, 02 Mar 2003 14:41:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove DEVFS_FL_AUTO_DEVNUM
References: <20030301190724.B1900@lst.de>	<b3tor7$uqu$1@cesium.transmeta.com> <15970.34318.504586.674652@notabene.cse.unsw.edu.au>
In-Reply-To: <15970.34318.504586.674652@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> Given the premise "Linus will not allow new static major/minors",
> I think it is essential :-(
> 

It's also a totally nonrealistic premise, which is why new allocations 
are still happening at the request of Alan and Marcelo.

	-hpa


