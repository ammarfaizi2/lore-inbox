Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbSALU7w>; Sat, 12 Jan 2002 15:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287472AbSALU7n>; Sat, 12 Jan 2002 15:59:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33546 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287450AbSALU72>; Sat, 12 Jan 2002 15:59:28 -0500
Message-ID: <3C40A39F.8030703@zytor.com>
Date: Sat, 12 Jan 2002 12:59:11 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
In-Reply-To: <20020112004528.A159@earthlink.net> <a1ooql$ili$1@cesium.transmeta.com> <20020112141738.L1482@inspiron.school.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> 
> actually it is really max virtual memory.. but from the user point of
> view, user is supposed to care about the virtual memory he can manage,
> not about what the kernel will do with the rest. So if the user wants
> 3GB of virtual memory available to each task he will select 3GB. I
> really don't mind if you want to change it from the kernel point of
> view, but given it's the user who's supposed to compile it, also the
> current patch looks good enough to me.
> 


Oh, right... if so he simply has the 05G option mislabelled... it should 
be 3.5G

	-hpa


