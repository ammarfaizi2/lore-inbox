Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSHPBXC>; Thu, 15 Aug 2002 21:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317858AbSHPBXC>; Thu, 15 Aug 2002 21:23:02 -0400
Received: from mail3.efi.com ([192.68.228.90]:52493 "HELO
	fcexgw03.efi.internal") by vger.kernel.org with SMTP
	id <S317855AbSHPBXC>; Thu, 15 Aug 2002 21:23:02 -0400
Message-ID: <3D5C5498.867E0359@efi.com>
Date: Thu, 15 Aug 2002 18:25:44 -0700
From: Kallol Biswas <kallol@efi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: wild card MAC address
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure if this message is posted to the right mailing list.

Is there any way to specify wildcard mac adress in the bootptab file?
It looks like no, the bootpd applies hash algorithm on the hardware
address
of the incoming bootp client request and sends a reply.

