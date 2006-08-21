Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWHUO1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWHUO1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWHUO1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:27:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:18194 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751885AbWHUO1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:27:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jqubEUEBxbH86DTlg0dokP4fGpnZiw9mzhTPaIu3ZXuyg9BQpwH7bB/XP4d3daIJpdzrn3+p5GGooTYfZR+Fvd3mF3vsA3PvwuyFmPZI0EheN/no/BelLuKBzTjEu6KBc6timD3Gxly+luHSe0SibVcrz7Yf6uqNMqhKu1b/g/w=
Message-ID: <7ac1e90c0608210727m1c5375b9xb936168c877084c@mail.gmail.com>
Date: Mon, 21 Aug 2006 15:27:50 +0100
From: "Bahadir Balban" <bahadir.balban@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: disabling dma/new ide interface 2.6.18-rc4-mm1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to implement a basic ide driver based on ata_generic.c.
Its a pio-only device.

How do I disable dma on the new interface? Changing ata_port_info fields?

Thanks,
Bahadir
