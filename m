Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTBBLH2>; Sun, 2 Feb 2003 06:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbTBBLH2>; Sun, 2 Feb 2003 06:07:28 -0500
Received: from ulima.unil.ch ([130.223.144.143]:37775 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S265197AbTBBLH2>;
	Sun, 2 Feb 2003 06:07:28 -0500
Date: Sun, 2 Feb 2003 12:16:57 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: is usb working under 2.5.59?
Message-ID: <20030202111657.GA31683@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I used to use usb under 2.4 with my Digital Ixus V with s10sh.
It worked just perfectly, now under 2.5.59, I don't even see the output
of a recongnize in the syslogd.

I have also tried gphoto2, which doesn't find any camera...

I have a MSI Max2-BLR motherboard with USB 2.0 on it:

lspci -v, the kernel config I use, /proc/bus/usb/devices, lsmod and dmesg
could be found under http://ulima.unil.ch/greg/linux/MAX2/

Should I provide some other info?

I could attach them if you prefer :-)

Should I change anything in my config?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
