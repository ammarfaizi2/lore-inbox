Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263356AbSJ3DV6>; Tue, 29 Oct 2002 22:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSJ3DV6>; Tue, 29 Oct 2002 22:21:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27655 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263356AbSJ3DV6>;
	Tue, 29 Oct 2002 22:21:58 -0500
Message-ID: <3DBF51B7.5070906@pobox.com>
Date: Tue, 29 Oct 2002 22:27:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] factor common GCC options check
References: <3DBF4ED4.3060203@quark.didntduck.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you were really motivated you could test for and add the options I 
added to gcc a couple months ago,
    -march={winchip-c6,winchip2,c3}



