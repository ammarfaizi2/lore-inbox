Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268989AbUIQQCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268989AbUIQQCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269000AbUIQP5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:57:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46060 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268989AbUIQPzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:55:13 -0400
Message-ID: <414B08D5.2020804@pobox.com>
Date: Fri, 17 Sep 2004 11:55:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Schirmer <jolt@tuxbox.org>
CC: Pekka Pietikainen <pp@ee.oulu.fi>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][2/4] b44: Cleanup SiliconBackplane definitions/functions
References: <200408292218.00756.jolt@tuxbox.org> <200408292234.04238.jolt@tuxbox.org>
In-Reply-To: <200408292234.04238.jolt@tuxbox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schirmer wrote:
> Hi,
> 
> there is a good amount of code to support SiliconBackplane functions which are unneeded or simply plain wrong. Lets get rid of it.
> 
> Regards,
>   Florian
> 
> Signed-off-by: Florian Schirmer <jolt@tuxbox.org>


patch applied to 2.6.x.


