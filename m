Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274080AbRISOvu>; Wed, 19 Sep 2001 10:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274078AbRISOvk>; Wed, 19 Sep 2001 10:51:40 -0400
Received: from t2.redhat.com ([199.183.24.243]:6904 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S274077AbRISOvQ>; Wed, 19 Sep 2001 10:51:16 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3BA8903D.2643D20D@didntduck.org> 
In-Reply-To: <3BA8903D.2643D20D@didntduck.org>  <30185.1000900519@redhat.com> 
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Direct PCI access broken in 2.4.10-pre 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Sep 2001 15:51:33 +0100
Message-ID: <22027.1000911093@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bgerst@didntduck.org said:
>  Patch attached that fixes typecasting problems with PCI Type 2
> accesses.

That appears to fix it. Thanks.

--
dwmw2


