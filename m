Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSIBIqY>; Mon, 2 Sep 2002 04:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSIBIqY>; Mon, 2 Sep 2002 04:46:24 -0400
Received: from xsmtp.ethz.ch ([129.132.97.6]:22799 "EHLO xsmtp.ethz.ch")
	by vger.kernel.org with ESMTP id <S315260AbSIBIqX>;
	Mon, 2 Sep 2002 04:46:23 -0400
Message-ID: <3D732667.70102@debian.org>
Date: Mon, 02 Sep 2002 10:50:47 +0200
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en, it-ch, it, fr
MIME-Version: 1.0
To: Thunder from the hill <thunder@lightweight.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] make localconfig
References: <fa.nh1hfav.83mprq@ifi.uio.no> <fa.lgtjqtv.71gjhi@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Sep 2002 08:50:53.0430 (UTC) FILETIME=[D84F3160:01C2525D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have some bash code (to probe hardware), an hardware/driver database
and a python script to partly generate the database direct from
kernel sources.
It should be in http://people.debian.org/~cate/files/kautoconfigure
and in http://people.debian.org/~cate/files/gnome-os

If someone find it usefull I can continue to work on that.

ciao
	cate


Thunder from the hill wrote:
> Hi,
> 
> On Sun, 25 Aug 2002, Zwane Mwaikambo wrote:
> 
>>For this kind of thing, code talks. Otherwise no one will take heed.
> 
> 
> I can't currently supply code, but the thing I'm doing is:
> 
>  - parse the dmesg for the vital stuff (the things that were loaded up to 
>    the moment may be used very often...)
>  - Find out what code it's belonging to
>  - Configure that code in
>  - The rest is CONFIG_MODULE
> 
> So what?
> 
> 			Thunder


