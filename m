Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTBTQvw>; Thu, 20 Feb 2003 11:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbTBTQvw>; Thu, 20 Feb 2003 11:51:52 -0500
Received: from sunmgr.hti.com ([130.210.206.69]:35535 "EHLO issun6.hti.com")
	by vger.kernel.org with ESMTP id <S266114AbTBTQvv>;
	Thu, 20 Feb 2003 11:51:51 -0500
Message-ID: <3E5509C8.DFE6FD34@link.com>
Date: Thu, 20 Feb 2003 11:00:56 -0600
From: "Casey Lancour" <cjlancour@link.com>
X-Mailer: Mozilla 4.7 [en]C-CCK-MCD   (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 8x AGP under linux?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know the status to 8x agp support under linux?
I am using the Granite bay 7205 chipset and I cant get my geforce4 card
to use agpgart or nvidia's agp support, it seems to be defaulting to pci
mode (not even using 4x agp).
I do a:

cat /proc/driver/nvidia/agp/status

which is my indication that i am not using agp bus to its fullest.


     -=Casey

