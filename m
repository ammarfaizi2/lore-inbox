Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVLTEoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVLTEoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 23:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVLTEoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 23:44:54 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:22486 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbVLTEoy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 23:44:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L2kkjPP2GGjTSwz0DbCHIqj5UfnKyszffyzbBocEX/i35vL9F9jUUqc7SJs0hkaMVkCT0N3cT7QcLfmnz0YASd4mQ3AzbvLXmRo7AGSOQg5VCrnKhHmA6IjzxzcDeYrfLgB+Ez2VwaIeCYee/tOTyl7QxtWzwcDLPSN1uijolBQ=
Message-ID: <7a37e95e0512192044s7cd8cce4y56ff9cfce06b44c3@mail.gmail.com>
Date: Tue, 20 Dec 2005 10:14:51 +0530
From: Deven Balani <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: scatter-gather list.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am trying to port a driver from x86 PCI based platform to ARM platform.

The x86 driver has scatter-gather list as one of the DMA mechanism.
Can I bypass this, As I believe sg list is for PCI buses and not for HSX buses.

Can any one give me the _source_ where I can understand the necessity for
a PCI bus to use sg list.


Regards,
deven
