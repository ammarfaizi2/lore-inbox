Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268894AbTBZUPO>; Wed, 26 Feb 2003 15:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268896AbTBZUPO>; Wed, 26 Feb 2003 15:15:14 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:12210 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S268894AbTBZUPN>; Wed, 26 Feb 2003 15:15:13 -0500
Message-Id: <5.1.0.14.2.20030226121907.02206148@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 26 Feb 2003 12:21:16 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
In-Reply-To: <20030225050306.E53BC2C054@lists.samba.org>
References: <Your message of "Mon, 24 Feb 2003 11:35:03 -0800." <5.1.0.14.2.20030224112723.05a5e640@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:02 PM 2/24/2003, Rusty Russell wrote:
>In message <5.1.0.14.2.20030224112723.05a5e640@mail1.qualcomm.com> you write:
>> appropriate name for that function. But I can live with __try_module_get() :)
>> I'll make new patch for net/socket.c as soon as yours goes in.
>
>Linus, please apply.  This is the "module_dup" which Viro wanted, by
>another name.

Rusty,
Looks like Linus ignored this thread. He applied your other patches but not this one.
Could please resend it with the new subject or something.

Thanks
Max

