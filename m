Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbTAOG0y>; Wed, 15 Jan 2003 01:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTAOG0y>; Wed, 15 Jan 2003 01:26:54 -0500
Received: from kra-81-27-195-8.tesnetwork.cz ([81.27.195.8]:11783 "EHLO
	bagend.kralupy.cz") by vger.kernel.org with ESMTP
	id <S261376AbTAOG0x>; Wed, 15 Jan 2003 01:26:53 -0500
From: Richard Bouska <Richard@Bouska.cz>
To: linux-kernel@vger.kernel.org
Subject: USB: Sony clie does not word with recent 2.5 
Date: Wed, 15 Jan 2003 07:35:41 +0100
User-Agent: KMail/1.5
Cc: greg@kroah.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301150735.41914.Richard@Bouska.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am not able to sync the Clie SL10 with the recent 2.5 kernels - with 2.4 
everything works.
The visor and usbserial are modules, but I dont think it changes anythink.

syslog of 2.5.58:

hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 3
usb 1-2: palm_os_4_probe - error -32 getting connection info
visor 1-2:0: Handspring Visor / Treo / Palm 4.0 / Cli<E9> 4.x converter 
detected
usb 1-2: Handspring Visor / Treo / Palm 4.0 / Cli<E9> 4.x converter now 
attached to ttyUSB0 (or usb/tts/0 for devfs)
usb 1-2: Handspring Visor / Treo / Palm 4.0 / Cli<E9> 4.x converter now 
attached to ttyUSB1 (or usb/tts/1 for devfs)
usb 1-2: USB disconnect, address 3
visor ttyUSB0: Handspring Visor / Treo / Palm 4.0 / Cli<E9> 4.x converter now 
disconnected from tty USB0
visor ttyUSB1: Handspring Visor / Treo / Palm 4.0 / Cli<E9> 4.x converter now 
disconnected from tty USB1
visor 1-2:0: device disconnected

Thank for any help
Richard Bouska
Richard@Bouska.cz

