Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316952AbSFWB2N>; Sat, 22 Jun 2002 21:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316953AbSFWB2M>; Sat, 22 Jun 2002 21:28:12 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:50908 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S316952AbSFWB2L>; Sat, 22 Jun 2002 21:28:11 -0400
Date: Sat, 22 Jun 2002 21:32:03 -0400
From: sean darcy <seandarcy@hotmail.com>
Subject: Re: piggy broken in 2.5.24 build
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3D152513.8010801@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
References: <linux.kernel.Pine.LNX.4.44.0206221501430.7338-100000@chaos.physics.uiowa.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> On Sat, 22 Jun 2002, sean darcy wrote:
> 
> 
>>At the end of make bzImage I get:
>>
...................
> So the question is why does the objcopy ... line not generate the tmp_xx
> file. I don't see it spitting out any error either, but could you check
> the obvious, like remaining free space on that filesystem and /tmp?
> 
........................
> --Kai
> 
20 gigs free. Aren't these big new disks great?

Glad it's not a build problem. Just wish I could figure out what kind of 
problem it is.

jay


