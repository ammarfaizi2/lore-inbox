Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262081AbSJBA5f>; Tue, 1 Oct 2002 20:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262311AbSJBA5f>; Tue, 1 Oct 2002 20:57:35 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:26833 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S262081AbSJBA5f>; Tue, 1 Oct 2002 20:57:35 -0400
Message-ID: <3D9A4571.7070600@hotmail.com>
Date: Tue, 01 Oct 2002 18:01:37 -0700
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.1) Gecko/20020921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: problems loading/unloading ide-scsi modules
References: <fa.iqpamnv.18n6gj8@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:

> ...When I started rmmoding modules I was able to duplicate what others 
> were seeing.  This could be associated with module loading in general, but 
> I am able to load/unload other modules without problem...

    <snippage>

> If I try to rmmod sr_mod I get:

>  Segmentation fault

That's what I saw with insmod for ppa.o today.  I wonder if the modutils need
to be recompiled?

