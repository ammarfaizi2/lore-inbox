Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbSJHWJs>; Tue, 8 Oct 2002 18:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSJHWJs>; Tue, 8 Oct 2002 18:09:48 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:50168 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261402AbSJHWJq>; Tue, 8 Oct 2002 18:09:46 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021008.150444.118305428.davem@redhat.com> 
References: <20021008.150444.118305428.davem@redhat.com>  <200210060846.g968klWf000632@pool-141-150-241-241.delv.east.verizon.net> <3D9FFD21.8040404@pobox.com> <8973.1034111628@passion.cambridge.redhat.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: skip.ford@verizon.net, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Oct 2002 23:15:20 +0100
Message-ID: <18079.1034115320@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
>  Should we have two lists, one for 2.4 and one for 2.5?
> I'll set it up once decided.

Probably one for each. We could add headers which say which branch it is 
but that's still a lot of extra traffic for subscribers who only want the 
stable branch info and will filter the 2.5 ones to /dev/null.

How about
 bk-commits-head
 bk-commits-2.4

then later bk-commits-2.6 etc...


--
dwmw2


