Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282882AbRK0JAZ>; Tue, 27 Nov 2001 04:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282881AbRK0JAQ>; Tue, 27 Nov 2001 04:00:16 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:64017 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282879AbRK0JAJ>;
	Tue, 27 Nov 2001 04:00:09 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Giacomo Catenazzi <cate@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16: 802.1Q VLAN non-modular 
In-Reply-To: Your message of "Tue, 27 Nov 2001 09:32:34 BST."
             <3C034FA2.3040804@debian.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Nov 2001 19:59:56 +1100
Message-ID: <1835.1006851596@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 09:32:34 +0100, 
Giacomo Catenazzi <cate@debian.org> wrote:
>Keith Owens wrote:
>> .force_default (kbuild 2.4)
> 
>> Patch against 2.4.16.
>> 
>> Index: 16.1/scripts/Configure
>> --- 16.1/scripts/Configure Tue, 03 Jul 2001 11:11:12 +1000 kaos (linux-2.4/38_Configure 1.1.2.1 644)
>> +++ 16.1(w)/scripts/Configure Tue, 27 Nov 2001 13:15:40 +1100 kaos (linux-2.4/38_Configure 1.1.2.1 644)
>
>
>Could you upload this two files to
>
>http://sourceforge.net/projects/kbuild/ ?
>
>(maybe as docs)

The Configure patch is already part of kbuild 2.5, just apply that
patch.  Each user needs their own .force_default file.

