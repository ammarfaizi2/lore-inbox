Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263786AbRFRItf>; Mon, 18 Jun 2001 04:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263823AbRFRItQ>; Mon, 18 Jun 2001 04:49:16 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:56069 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S263786AbRFRItN>; Mon, 18 Jun 2001 04:49:13 -0400
Date: Mon, 18 Jun 2001 16:48:34 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Christian Robottom Reis <kiko@async.com.br>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, <eepro100@scyld.com>,
        <saw@saw.sw.com.sg>, <linux-kernel@vger.kernel.org>,
        Jeff Chua <jchua@fedex.com>
Subject: Re: eepro100 problems with 2.2.19 _and_ 2.4.0
In-Reply-To: <Pine.LNX.4.32.0106171608580.140-100000@blackjesus.async.com.br>
Message-ID: <Pine.LNX.4.33.0106181647490.270-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2001, Christian Robottom Reis wrote:

> > Try to add "options eepro100 options=0" to your /etc/modules.conf
> > to default the speed to 10Mbps if you're using 10BaseT.
>
> I'm not using modules for this driver (can't see the point, really); does
> this fix anything if I change it to 0x20 for 100BaseT?
>
try to pass the options when you boot up linux and see if it helps

Jeff

