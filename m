Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbTCEPwK>; Wed, 5 Mar 2003 10:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbTCEPwK>; Wed, 5 Mar 2003 10:52:10 -0500
Received: from terminus.zytor.com ([63.209.29.3]:10189 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S267135AbTCEPwJ>; Wed, 5 Mar 2003 10:52:09 -0500
Message-ID: <3E661F8F.50100@zytor.com>
Date: Wed, 05 Mar 2003 08:02:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@user.it.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to boot a raw kernel image :??
References: <20021129132126.GA102@DervishD>	<3DF08DD0.BA70DA62@gmx.de>	<b453er$qo7$1@cesium.transmeta.com>	<15974.6329.574794.597753@gargle.gargle.HOWL>	<3E661C1D.904@zytor.com> <15974.7817.474141.453202@gargle.gargle.HOWL>
In-Reply-To: <15974.7817.474141.453202@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
>  > 
>  > This is the patch I'm trying to get Linus to accept.
> 
> That's similar to what you posted to LKML a while ago, and
> it has the limitations of requiring mountable /dev/fd0, which
> needs a magic entry in /etc/fstab ("user" privs, not "owner"),
> and MS-DOS FS support in the kernel used for the build.
> 

No, it doesn't (if you have SYSLINUX 2.02 or higher.)

	-hpa

