Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbTCJT1n>; Mon, 10 Mar 2003 14:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbTCJT1m>; Mon, 10 Mar 2003 14:27:42 -0500
Received: from terminus.zytor.com ([63.209.29.3]:34778 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S261288AbTCJT1k>; Mon, 10 Mar 2003 14:27:40 -0500
Message-ID: <3E6CE9A5.7070304@zytor.com>
Date: Mon, 10 Mar 2003 11:38:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: DervishD <raul@pleyades.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to boot a raw kernel image :??
References: <20021129132126.GA102@DervishD> <15974.7817.474141.453202@gargle.gargle.HOWL> <3E661F8F.50100@zytor.com> <15975.8192.437452.801287@gargle.gargle.HOWL> <b48b0l$5rl$1@cesium.transmeta.com> <20030309103104.GA61@DervishD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi HPA :)
> 
> 
>>>Indeed. The SYSLINUX 2.02 + mtools combination works like a charm
>>>for 'make bzdisk'. I'm happy with your nobootsect patch.
>>
>>Well, Linus keeps dropping it on the floor, so I don't know if we'll
>>see a working "make bzdisk" in the kernel any time soon :(
> 
> 
>     Do you know why?
> 

No, especially not as it turns out I was wrong -- the patch is currently 
in the snapshots.

	-hpa


