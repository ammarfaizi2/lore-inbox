Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTD3G7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 02:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTD3G7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 02:59:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:33021 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262108AbTD3G7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 02:59:04 -0400
From: Christian =?iso-8859-1?q?Borntr=E4ger?= <linux@borntraeger.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [BUG 2.5.67 (and probably earlier)] /proc/dev/net doesnt show all net devices
Date: Wed, 30 Apr 2003 09:11:11 +0200
User-Agent: KMail/1.5.1
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
References: <200304291434.18272.linux@borntraeger.net> <20030429092857.4ebffcc9.rddunlap@osdl.org> <20030429130742.2c38b5f3.rddunlap@osdl.org>
In-Reply-To: <20030429130742.2c38b5f3.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304300911.11287.linux@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | Christian, can you test this patch?

I can....

> Oh well, I don't think that works.

should I nevertheless test this patch?

> How do I configure the dummy network driver to get loads of interfaces?

Just copy the dummy.o to dummy1.o dummy2.o dummy3.o,  insmod and ifconfig 
them.

cheers Christian
