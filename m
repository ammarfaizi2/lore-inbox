Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbTCaHcV>; Mon, 31 Mar 2003 02:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbTCaHcV>; Mon, 31 Mar 2003 02:32:21 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:39377 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S261442AbTCaHcU>; Mon, 31 Mar 2003 02:32:20 -0500
Message-ID: <7A5D4FEED80CD61192F2001083FC1CF906514C@CHARLY>
From: "Filipau, Ihar" <ifilipau@sussdd.de>
To: "'linux@horizon.com'" <linux@horizon.com>,
       "'Ingo Oeser'" <ingo.oeser@informatik.tu-chemnitz.de>,
       "'Jonathan Lundell'" <linux@lundell-bros.com>,
       "'Pavel Machek'" <pavel@ucw.cz>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: inw/outw performance
Date: Mon, 31 Mar 2003 09:41:17 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All!

  Thanks every-one for your replies - it was really helpful.
  I gave our HW guys more job ;-)

  The only question I have left - and what is really more 
  linux-kernel related: is it okay to have ~200-400us IRQs
  disabled? I cannot effectively clear interrupt on device 
   - but I can disable interrupt on our PCI bridge, and later 
  in BH, after clearing irq on device, reenable irq line on
  bridge.

2Linux@Horizon: home of PLX PCI 9052 - www.plxtech.com
                PCI bridge for custom devices.

2Pavel: got not response - looks like you have enough of your 
        own unemployed ;-)

--- Regards&Wishes! With respect  Ihar "Philips" Filipau, and Phil for
friends

- - - - - - - - - - - - - - - - - - - - - - - - -
MCS/Mathematician - System Programmer
Ihar Filipau 
Software entwickler @ SUSS MicroTec Test Systems GmbH, 
Suss-Strasse 1, D-01561 Sacka (bei Dresden)
e-mail: ifilipau@sussdd.de  tel: +49-(0)-352-4073-327
fax: +49-(0)-352-4073-700   web: http://www.suss.com/
