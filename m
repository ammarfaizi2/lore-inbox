Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSJ1FD6>; Mon, 28 Oct 2002 00:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262878AbSJ1FD5>; Mon, 28 Oct 2002 00:03:57 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:59121 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262877AbSJ1FD5>; Mon, 28 Oct 2002 00:03:57 -0500
Message-ID: <3DBCC6FF.8070105@snapgear.com>
Date: Mon, 28 Oct 2002 15:11:27 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.44uc1 (MMU-less support)
References: <3DBAC09A.4090104@snapgear.com> <buoy98j8bia.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

Miles Bader wrote:
> 2.5.44uc1 doesn't seem to include the latest v850 changes I sent you (on
> 21 Oct, against 2.5.44uc0), though DaveM responded saying he had applied
> that patch.
> 
> Did something get screwed up, or is 2.5.44uc1 just very old?

Sorry, my mistake. I forgot to update those files in my local tree.
I just pushed out a linux-2.5.44uc3 that contains them.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

