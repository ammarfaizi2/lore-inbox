Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVHaVaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVHaVaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVHaVaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:30:24 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:55307 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964978AbVHaVaX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:30:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HHOWR+t2PG+mP4eXf8MOP8eV6xLYv9Svc9JjbjvbsMZVpTx7gkoCG3YI/Zz0T/8eJtfaGedXMIOrnqhZHRTAfsIQQrECGqn8wwK2QDgdUWNOYuN80xlg3dW+GdoynL/3EdZnp5JYB7PdjBpsMeDCghVgcaofFEgSnctUobd5E+0=
Message-ID: <fb3f6bf105083114301bb8b604@mail.gmail.com>
Date: Wed, 31 Aug 2005 17:30:22 -0400
From: Larry Lindsey <larry.the.pirate@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.27 and the ata_piix (Intel SATA) driver
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to backport ata_piix SATA support to the 2.4.27 kernel.  I
found some patches at the jgarzik people page, but they didn't work. 
I'm building a 2.4.27 kernel with the drivers/scsi from 2.4.29.  Is
there anything else that I should do?  Should I be worried about any
issues?

Thanks,
Larry

PS. Please CC responses to larry.the.pirate@gmail.com
