Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278572AbRJXPbd>; Wed, 24 Oct 2001 11:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278583AbRJXPbY>; Wed, 24 Oct 2001 11:31:24 -0400
Received: from defiant.coinet.com ([204.245.234.17]:10504 "HELO
	defiant.coinet.com") by vger.kernel.org with SMTP
	id <S278572AbRJXPbI>; Wed, 24 Oct 2001 11:31:08 -0400
Date: Wed, 24 Oct 2001 08:31:41 -0700
From: Gary Mart <gmart@coinet.com>
To: linux-kernel@vger.kernel.org
Subject: missing RealTek 8129/8139 (not 8019/8029!) support
Message-ID: <20011024083141.A10635@defiant.coinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sirs:

"RealTek 8129/8139 (not 8019/8029!) support"
seems to be missing from 'make menuconfig' in linux-2.2.19.tar.bz2.

And CONFIG_RTL8139 was not in the .config file.  However, when I
added CONFIG_RTL8139=m by hand to .config the module was built.

I checked on an earlier kernel and the RealTek support option
appears right before the "Other ISA cards" option.

Gary Mart
gmart@coinet.com
