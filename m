Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSGWQtx>; Tue, 23 Jul 2002 12:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318129AbSGWQtx>; Tue, 23 Jul 2002 12:49:53 -0400
Received: from mail-out2.apple.com ([17.254.0.51]:39646 "EHLO
	mail-out2.apple.com") by vger.kernel.org with ESMTP
	id <S318123AbSGWQtx>; Tue, 23 Jul 2002 12:49:53 -0400
Message-ID: <3D3D89EC.70102@nighton.net>
Date: Tue, 23 Jul 2002 09:53:00 -0700
From: David Love <dlove@nighton.net>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Schwengeler <schweng@master2.astro.unibas.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: freeze during NFS copy to IDE disks kernel 2.5.27
References: <200207231457.QAA01550@master2.astro.unibas.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Schwengeler wrote:
> 
> I am at a loss what to do. It seems that all 2.5 kernels that I have tested
> have serious problems with IDE (at least in combination with NFS).
> 

Yep, that's right - don't use 2.5 if you need anything near solid IDE. 
The most advocated solution (as far as I can tell) is to use the 2.4 IDE 
code forward-port if you need stable IDE on 2.5.

-D.Love

