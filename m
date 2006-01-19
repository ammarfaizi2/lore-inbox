Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWASQ3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWASQ3O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWASQ3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:29:13 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:64826 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030427AbWASQ3N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:29:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JHjwIlZEgXyz5sn8of6xmyz6EFjWCEmaSBkK3unK7NfkBhVzYeFH8FEXadO+RhOzbDXKPqmljKZG/abosU69cJTJSBm7uwDuFsEZUrZ6U8J5SxqKPOeOdduKlm7GLLHtrjscxnRViGuaWWMZ6dq7W/QYSozxLUqcuQ9ivkGUP8s=
Message-ID: <7a37e95e0601190829w6538856h9ff0eb33faf1100a@mail.gmail.com>
Date: Thu, 19 Jan 2006 21:59:12 +0530
From: Deven Balani <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Any Driver builds a non-PCI scatter-gather table to do a DMA transfer
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

I am writing a driver on an ARM platform which needs to build a
scatter-gather table to
do the DMA transaction.
Can any one refer a driver which already implements such a mechanism
for non-PCI Bus on linux-2.4.x kernels.

Regards,
Deven
--
"A smile confuses an approaching frown..."
