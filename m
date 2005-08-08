Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVHHVrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVHHVrz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVHHVrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:47:55 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:51197 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S932275AbVHHVry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:47:54 -0400
Message-ID: <42F7D313.4020109@schnuerer-online.de>
Date: Mon, 08 Aug 2005 23:48:03 +0200
From: "Thomas S." <thomas@schnuerer-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [linuxppc] 2.6.12-3 header <asm/usb.h> missing ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Im using Kernel PPC on a MPC5200 board and try to use the onChip USB. In
file /drivers/usb/host/ohci-ppc-soc.c a file <asm/usb.h> is included
which seems to be missing. I cant find it anywhere , any ideas ?

Thomas




