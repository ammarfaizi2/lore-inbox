Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSJAVdL>; Tue, 1 Oct 2002 17:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262889AbSJAVdL>; Tue, 1 Oct 2002 17:33:11 -0400
Received: from jalon.able.es ([212.97.163.2]:50630 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262887AbSJAVdK>;
	Tue, 1 Oct 2002 17:33:10 -0400
Date: Tue, 1 Oct 2002 23:35:11 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UFS filesystem
Message-ID: <20021001213511.GA3152@werewolf.able.es>
References: <20020929231904.161b5a00.spyro@f2s.com> <20020930201520.5ab47124.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020930201520.5ab47124.spyro@f2s.com>; from spyro@f2s.com on Mon, Sep 30, 2002 at 21:15:20 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.30 Ian Molton wrote:
>On Sun, 29 Sep 2002 23:19:04 +0100
>Ian Molton <spyro@f2s.com> wrote:
>
>> Hi.
>> 
>> I'd like to use linux to create a UFS filesystem, but cant find the
>> utilities to go along with the kernel module.
>> 
>> Documentation/filesystems/ufs.txt doesnt have any clues.
>
>Anyone? I think I need 'newfs' but cant find it anywhere...

I think it is not ported to linux... or is it ?

I have just found this, but is BSD-ish and does not build on Linux:

http://www.xinetd.org/pub/darwin/linux/newfs.ufs.tar.gz

Will dig a little more...


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre8-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
