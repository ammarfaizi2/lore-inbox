Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbTIPXl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 19:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbTIPXl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 19:41:26 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:57028 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S262556AbTIPXlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 19:41:24 -0400
Message-ID: <1063755675.3f679f9b3e0f7@dubai.stillhq.com>
Date: Wed, 17 Sep 2003 09:41:15 +1000
From: Michael Still <mikal@stillhq.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [2.6 Patch] Kernel-doc updates 7 of 15 -- /fs/inode.c
References: <1063681483.3f667dcbbf875@dubai.stillhq.com> <1063720681.10037.28.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063720681.10037.28.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox <alan@lxorguk.ukuu.org.uk>:

> On Maw, 2003-09-16 at 04:04, Michael Still wrote:
> >  
> >  /*
> 
> Should be /** there for dispose_list so that the entry is generated,
> otherwise it thinks its just a comment. The rest looks great

No problemmo -- I'll fix this when I resubmit slightly less broken patches.

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
