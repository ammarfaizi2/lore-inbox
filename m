Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUI1MGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUI1MGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 08:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUI1MGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 08:06:23 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:52341 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267660AbUI1MGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 08:06:09 -0400
Message-ID: <973453a104092805067533ffa5@mail.gmail.com>
Date: Tue, 28 Sep 2004 17:36:08 +0530
From: Rakesh Avichal Ughreja <rakesh.ughreja@gmail.com>
Reply-To: Rakesh Avichal Ughreja <rakesh.ughreja@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem in detecting PCItoPCI Bridges on cPCI Chassis
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a cPCI chassis, (21slots) in groups of 7. These groups are
connected by intel 21154 (PCI Bridges). I use Single Board Computer,
ZT5524 from PT which has standard Linux kernel 2.4.27(without any
patch) running on it.

The Linux kernel is unable to detect the Bridges present on the
chassis. Is there any patch available for adding cPCI support to Linux
kernel?

dmesg does not indicate anything at all. No warnnings no errors. Not
even lspci -M giving any clues.

Please CC me as I have not subcribed to the list.

-- 
Regards,
Rakesh

Success consists of going from failure to failure without loss of enthusiasm.
                                                                      
     ~ Winston Churchill ~
