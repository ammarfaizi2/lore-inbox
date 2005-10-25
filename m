Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVJYMLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVJYMLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 08:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVJYMLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 08:11:44 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:31070 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932136AbVJYMLo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 08:11:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XFIWzDPXiyzmeaJmeuacqZ90LDagyvoNiAqIf8rBlVjveYVxbARWCDrhmKTFolFbGVigvM/8FOP7QcU14ewJMU+S13lrBrTsUIiQrS4GScMGyX3BmMGjVpZtgpI/98wSFGwSVL1Two2mKiHcNOH5s0GaEZQPEauBhLrUK3XyMf4=
Message-ID: <7a37e95e0510250511g631db9edoe4c739ed24b7a79b@mail.gmail.com>
Date: Tue, 25 Oct 2005 17:41:42 +0530
From: Deven Balani <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: reference code for non-PCI libata complaint SATA for ARM boards.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

I am currently writing a low-level driver for non-PCI SATA controller
in ARM platform.which uses libata-core.c for linux-2.4.25. Can any one
tell me any reference code available under linux.

Regards,
balani


--
"A smile confuses an approaching frown..."
