Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319483AbSH3OC7>; Fri, 30 Aug 2002 10:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319566AbSH3OC7>; Fri, 30 Aug 2002 10:02:59 -0400
Received: from danielle.hinet.hr ([195.29.148.143]:42385 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S319483AbSH3OC6>; Fri, 30 Aug 2002 10:02:58 -0400
Date: Fri, 30 Aug 2002 16:07:19 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: USB mouse in 2.4.19-pre4 vs later
Message-ID: <20020830140719.GA24738@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after 2.4.19-pre4 (or could it be pre5 I haven't tried pre5)
my USB mouse stopped working in X.

Only relevant diff I could find is (same .config) ->

-input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:3.0
+hiddev0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:3.0

this is 19-pre4 vs 19-pre6.

Any help ?
TIA,


-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
