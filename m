Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312838AbSCZXbu>; Tue, 26 Mar 2002 18:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312833AbSCZXbh>; Tue, 26 Mar 2002 18:31:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21772 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312834AbSCZXbE>;
	Tue, 26 Mar 2002 18:31:04 -0500
Message-ID: <3CA1044F.6020709@mandrakesoft.com>
Date: Tue, 26 Mar 2002 18:29:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: up-to-date bk repository?
In-Reply-To: <3CA0FEF7.90003@candelatech.com> <20020326.151104.118632068.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>echo -n >include/asm-i386/proc_fs.h
>make
>
Carpel tunnel fans prefer  "> include/asm-i386/proc_fs.h"   :)

removing asm/proc_fs.h include works too as a _temporary_ solution...

    Jeff






