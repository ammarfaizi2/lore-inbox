Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135444AbREBEtB>; Wed, 2 May 2001 00:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135896AbREBEsv>; Wed, 2 May 2001 00:48:51 -0400
Received: from mail.zabbadoz.net ([195.2.176.194]:26884 "EHLO
	mail.zabbadoz.net") by vger.kernel.org with ESMTP
	id <S135444AbREBEsh>; Wed, 2 May 2001 00:48:37 -0400
Date: Wed, 2 May 2001 06:53:49 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb+linuxkernel@zabbadoz.net>
To: <tpepper@vato.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.4 breaks VMware
In-Reply-To: <3AEF694A.6B1D7602@haque.net>
Message-ID: <Pine.BSF.4.30.0105020648090.47563-100000@noc.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Mohammad A. Haque wrote:

> tpepper@vato.org wrote:
> > This patch replaces a wee bit of code vmware wanted in include/linux/skbuff.h
> > although I'm guessing it was removed for a reason and vmware should be patched
> > to use the new method.
> >
>
> Better to patch vmware rather than the kernel. Here's a patch thet
> should be applied to source files in
> /usr/lib/vmware/modules/source/vmnet.tar

An even better solution would be getting vmware 2.0.4 which seems to
be a bit more 2.4-kernel compliant.
It is not yet announced on their web from what I can see but you may
already fetch it from p.ex. ftp://download1.vmware.com/pub/software/

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/


