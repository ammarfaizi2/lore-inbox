Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVF3RJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVF3RJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 13:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVF3RJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 13:09:13 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:46725 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262778AbVF3RJJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 13:09:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZF66gPDUdFAxHZx9Xiw5NYk4TyeAlKE6AbOb6w+qgJnZJrvwOmkVQz7SSwjWyP86/78cF1tlVnVsXBbDqTIYNfxwW3hSDIkdJHfuig31myQP9JqTlPu5EFl7iKTJOVcC3gCOEX/JwKLbv2KqW1Bx/ZFjSKBIkvL1lHPwGSGDIAM=
Message-ID: <4789af9e050630100934f81fca@mail.gmail.com>
Date: Thu, 30 Jun 2005 11:09:06 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
Reply-To: Jim Ramsay <jim.ramsay@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, kmalkki@cc.hut.fi,
       frodol@dds.nl, hpfan@mvista.com, source@mvista.com
Subject: i2c-adap-ite.h is missing from kernel tree
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get this i2c-ite.c (formerly 'i2c-adap-ite.c', in the
2.4 kernel) driver to compile in a 2.6.11 kernel, but there is the
following line which is a stumper:

#include <linux/i2c-adap-ite.h>

I can't for the life of me (or anywhere in google even!) find a file
called i2c-adap-ite.h in the 2.6 or 2.4 kernel.

Does anyone out there have it or know where it went?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
