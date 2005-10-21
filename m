Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVJUIkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVJUIkU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 04:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJUIkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 04:40:20 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:2128 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932550AbVJUIkS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 04:40:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dVuJiNnIHdYQ5UKWZjLH0RnUIgYSGw3CBYfMHx2m4IAYb9RxfvI2556IkvGVzwuXuY5PF9gkDNpG4HpV5QQvZzcXWeKhft1OGOdNOu3uiistXUnZ+j5VILx6GV//HhTw7y0tIH79EMQcboUxLDE61ZFWzpqUpwH4pRxyTnlwiFg=
Message-ID: <1ffb4b070510210140l5f0838e9i1d3860af47ef1296@mail.gmail.com>
Date: Fri, 21 Oct 2005 16:40:17 +0800
From: Mike Lee <eemike@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Different between SPI and SDIO
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
   Could david's simple SPI framework support full SDIO
implementation? Could i use the mmc device tree to perform SDIO
operations?
   SPI tree is now still not include in the kernel tree, Will it add
to kernel soon? any SDIO example driver for reference?

Thx for concern

-----------------------------------------------
Mike Lee
