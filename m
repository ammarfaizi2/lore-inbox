Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274968AbRJALkv>; Mon, 1 Oct 2001 07:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274965AbRJALkc>; Mon, 1 Oct 2001 07:40:32 -0400
Received: from t2.redhat.com ([199.183.24.243]:57585 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S274951AbRJALkU>; Mon, 1 Oct 2001 07:40:20 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3BB624D9.4080705@si.rr.com> 
In-Reply-To: <3BB624D9.4080705@si.rr.com> 
To: fdavis@si.rr.com
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] 2.4.9-ac17: jffs and jffs2 MODULE_LICENSE 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Oct 2001 12:40:33 +0100
Message-ID: <6317.1001936433@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fdavis@si.rr.com said:
> Hello,
>      The attached files add the MODULE_LICENSE statement to the jffs
> and  jffs2.

grep --after-context=2 JFFS MAINTAINERS

--
dwmw2


