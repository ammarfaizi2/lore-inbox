Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275097AbRJQIpU>; Wed, 17 Oct 2001 04:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRJQIpK>; Wed, 17 Oct 2001 04:45:10 -0400
Received: from t2.redhat.com ([199.183.24.243]:57597 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S275097AbRJQIoy>; Wed, 17 Oct 2001 04:44:54 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <9qjfki$ob5$1@cesium.transmeta.com> 
In-Reply-To: <9qjfki$ob5$1@cesium.transmeta.com>  <19978.1003206943@kao2.melbourne.sgi.com> <3BCBE29D.CFEC1F05@alacritech.com> 
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libz, libbz2, ramfs and cramfs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Oct 2001 09:45:24 +0100
Message-ID: <6828.1003308324@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hpa@zytor.com said:
>  PPP uses a nonstandard deviant of zlib, or *so I've been told*, so
> that one is out.

OOI, jffs2 used the PPP version of zlib, and mkfs.jffs2 uses the 
normal libz. No problems have been encountered so far.

--
dwmw2


