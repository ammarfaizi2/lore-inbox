Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132006AbRCVMcx>; Thu, 22 Mar 2001 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132005AbRCVMcn>; Thu, 22 Mar 2001 07:32:43 -0500
Received: from t2.redhat.com ([199.183.24.243]:8185 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131993AbRCVMch>; Thu, 22 Mar 2001 07:32:37 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3AB8E3E8.F3204180@yk.rim.or.jp> 
In-Reply-To: <3AB8E3E8.F3204180@yk.rim.or.jp> 
To: Ishikawa <ishikawa@yk.rim.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting post from the MC project to linux-kernel. :block while spinlock held... 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Mar 2001 12:31:36 +0000
Message-ID: <23752.985264296@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ishikawa@yk.rim.or.jp said:
> drivers/char/applicom.c

There's a rewrite of this for the new PCI API. Doesn't yet support the ISA 
cards because I didn't have one to test with. I'll try to get hold of one 
and submit it.

--
dwmw2


