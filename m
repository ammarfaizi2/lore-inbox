Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291800AbSBHUjC>; Fri, 8 Feb 2002 15:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291801AbSBHUiD>; Fri, 8 Feb 2002 15:38:03 -0500
Received: from f29.law11.hotmail.com ([64.4.17.29]:21767 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S291800AbSBHUhF>;
	Fri, 8 Feb 2002 15:37:05 -0500
X-Originating-IP: [156.153.254.10]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: linux-kernel@vger.kernel.org, tigran@veritas.com
Subject: KSTK_EIP and KSTK_ESP
Date: Fri, 08 Feb 2002 12:36:59 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F29wLdDnNMZr4DwRMLj000174e4@hotmail.com>
X-OriginalArrivalTime: 08 Feb 2002 20:36:59.0607 (UTC) FILETIME=[5B6C4670:01C1B0E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we really need these defines, I found that it
is not used anywhere and defined as deadbeef on
some architectures. Does it make sense to remove
these variables from the kernel source?

Balbir


_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

