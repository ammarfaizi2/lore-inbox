Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317769AbSFSFDF>; Wed, 19 Jun 2002 01:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317770AbSFSFDE>; Wed, 19 Jun 2002 01:03:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21765 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317769AbSFSFDD>; Wed, 19 Jun 2002 01:03:03 -0400
Message-ID: <3D101085.6010805@zytor.com>
Date: Tue, 18 Jun 2002 22:03:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.x: arch/i386/kernel/cpu
References: <aeouoe$a66$1@cesium.transmeta.com> <20020619063807.B25509@suse.de> <3D100BE7.4040802@zytor.com> <20020619065823.C25509@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  > 
>  > That's the 3DNow! bit... I was thinking it might be handled specially, 
>  > but it looks like that's only done for Centaur chips.  Are you sure your 
>  > CPU isn't being mis-identified as Centaur by the new code?
> 
> It is being (correctly) identified as Centaur.
> VIA Cyrixen are CentaurHauls family 6
> 

Well, then... there ya go :)

	-hpa


