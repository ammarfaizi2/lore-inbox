Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSEUSLC>; Tue, 21 May 2002 14:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSEUSLC>; Tue, 21 May 2002 14:11:02 -0400
Received: from web14702.mail.yahoo.com ([216.136.224.119]:60511 "HELO
	web14702.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315375AbSEUSLA>; Tue, 21 May 2002 14:11:00 -0400
Message-ID: <20020521181059.97314.qmail@web14702.mail.yahoo.com>
Date: Tue, 21 May 2002 11:10:59 -0700 (PDT)
From: Jing Xu <xujing_cn2001@yahoo.com>
Subject: enable interrupt in pci configuration space?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to enable the vertical retrace interrupt of my
AGP card by setting the value of a related register.
The document about this register mentions that" The
fields in this register control whether the respective
status bits are enabled to drive the system interrupt
pin. Even if enabled here, the interrupt line is not
driven unless enabled in the PCI configuration space."


Can we enable interrupt in PCI configuration space? If
we can, how to enable it? By the way, I am not in this
maillist. Could you please send a copy to me when you
give your suggestion.

Thanks in advance,

jing

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
