Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264707AbSKALN3>; Fri, 1 Nov 2002 06:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264861AbSKALN3>; Fri, 1 Nov 2002 06:13:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47889 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264707AbSKALN2>;
	Fri, 1 Nov 2002 06:13:28 -0500
Message-ID: <3DC26333.4040006@pobox.com>
Date: Fri, 01 Nov 2002 06:19:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dcinege@psychosis.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initrd Dynamic -- Initramfs's GrandDaddy...(and competition)
References: <200211010605.12473.dcinege@psychosis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Cinege wrote:

>What this has that initramfs doesn't:
>	Clean up and rewrite of the system already in place.
>	The use of tar archives
>	Multiple archive support
>	Works good, right now
>  
>

indeed :)


>What initramfs has that this doesn't:
>	Load image from a 'linked' kernel location.
>	Uses CPIO archives
>  
>

early userspace, which is the whole point of the exercise.

We want to move a bunch of stuff _out_ of the kernel to userspace.

    Jeff




