Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264696AbRFQIDC>; Sun, 17 Jun 2001 04:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbRFQICm>; Sun, 17 Jun 2001 04:02:42 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:37904 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S264696AbRFQICk>; Sun, 17 Jun 2001 04:02:40 -0400
Date: Sun, 17 Jun 2001 13:51:39 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: Reg:use of file_system_type structure
In-Reply-To: <Pine.LNX.4.10.10106171342310.11021-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10106171348580.11158-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Every file system has file_system_type structure defined. Where else this
structure is referred. Does register_filesystem() refer this structure.
Does sys_mount refer to this structure by any means?


Please help me with the info.

Thanks in advance,
Regards,
sathish.j


