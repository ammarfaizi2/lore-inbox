Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbTGEUj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266483AbTGEUj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:39:56 -0400
Received: from fe04.axelero.hu ([195.228.240.92]:2241 "EHLO
	amitabha.axelero.hu") by vger.kernel.org with ESMTP id S266479AbTGEUjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:39:55 -0400
Message-ID: <009401c34337$9fb86530$1164a8c0@AXIS>
From: "Xerex" <xerex@axelero.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Help with an error message
Date: Sat, 5 Jul 2003 22:54:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone help me out with this message, and do I need to worry about
it? May it be a mainboard error? I'm using only IDE drives with LBA ...

bash# mv /boot/vmlinuz-2.2.20-idepci /boot/vmlinuz-2.2.20-idepci.bak
bash# cp bzImage /vmlinuz
bash# lilo
Warning: Int 0x13 function 8 and function 0x48 return different
head/sector geometries for BIOS drive 0x80
Warning: Int 0x13 function 8 and function 0x48 return different
head/sector geometries for BIOS drive 0x81
Warning: Int 0x13 function 8 and function 0x48 return different
head/sector geometries for BIOS drive 0x82
Added Linux *
Skipping /vmlinuz.old

Thanks,
-----------------------------------------------------
Xerex
xerex@axelero.hu
------------------------------------------------------


