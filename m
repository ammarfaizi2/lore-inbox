Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269843AbRHIPaR>; Thu, 9 Aug 2001 11:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269846AbRHIPaH>; Thu, 9 Aug 2001 11:30:07 -0400
Received: from t2.redhat.com ([199.183.24.243]:39418 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S269844AbRHIP3w>; Thu, 9 Aug 2001 11:29:52 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <6361.997313081@ocs3.ocs-net> 
In-Reply-To: <6361.997313081@ocs3.ocs-net> 
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Duplicate symbols in -ac JFFS2 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Aug 2001 16:29:56 +0100
Message-ID: <32199.997370996@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  What happened to the idea of puttting the deflate code in its own
> object with exported symbols, instead of duplicating it in each
> directory? 

Planned for 2.5.

--
dwmw2


