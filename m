Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVCAF3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVCAF3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 00:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVCAF3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 00:29:41 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:17556 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261244AbVCAF3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 00:29:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jtR9dj/6xgrUU0hRJBNvTaNmAo1VThFKHEn8WmPxAkHtmPs9SyANrOgNWFQMkLMGXz6jjQ58oa3Bgi4mW5jsZ2rocRTpNq8yE6B//oobN+bav3mLuEpa7F2/oC8IMU/Z1Iq2OA4I2T8KJsZ9rJCvLx/4dH4n4qUzux5orK0yy/E=
Message-ID: <4223FDBC.8080504@gmail.com>
Date: Tue, 01 Mar 2005 14:29:32 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl> <200502271731.29448.bzolnier@elka.pw.edu.pl> <422337A1.4060806@gmail.com> <200502281714.55960.bzolnier@elka.pw.edu.pl> <20050301042116.GA9001@htj.dyndns.org>
In-Reply-To: <20050301042116.GA9001@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Oh, Bartlomiej, one more thing.

  If it isn't too much trouble, can you please set up a bk repository 
which contains the patches you've posted and whatever you're working on 
but hasn't yet made into ide-dev tree?  So that we don't have to juggle 
patches back and forth.  If you maintain your up-to-date working tree, 
I'll make my patches against that tree and if it's convinient for you, I 
can also set up an export tree you can pull from.

  Thanks.  :-)

-- 
tejun

