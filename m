Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUCKGEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUCKGEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:04:44 -0500
Received: from mail.veka.com ([213.68.6.130]:26542 "EHLO mail.veka.com")
	by vger.kernel.org with ESMTP id S261505AbUCKGEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:04:41 -0500
From: Frank Fiene <ffiene@veka.com>
Organization: VEKA AG
To: linux-kernel@vger.kernel.org
Subject: IBM Thinkpad with docking station
Date: Thu, 11 Mar 2004 07:04:33 +0100
User-Agent: KMail/1.6.1
References: <404F09C6.7030200@softhome.net> <Pine.LNX.4.53.0403100806570.15421@chaos> <404F2EA1.8030702@softhome.net>
In-Reply-To: <404F2EA1.8030702@softhome.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200403110704.34054.ffiene@veka.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i've problem with my Thinkpad A31p, USB and docking station.

Without the docking station, USB is working fine, if i plugin my 
notebook, following errors occur (i remember, that before upgrading to 
2.6.3 only one port could be used and with windoze both ports are ok):

hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: unknown reserved power switching mode
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
hub 1-0:1.0: port 1, status 101, change 1, 12 Mb/s
uhci_hcd 0000:00:1d.1: root hub device address 1
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: unknown reserved power switching mode
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
uhci_hcd 0000:00:1d.2: root hub device address 1
hub 1-0:1.0: port 1 not reset yet, waiting 50ms
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: unknown reserved power switching mode
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: Port indicators are not supported
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: hub controller current requirement: 0mA
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
hub 3-0:1.0: enabling power on all ports
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not enabled, trying reset again...
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not enabled, trying reset again...
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not enabled, trying reset again...
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not enabled, trying reset again...
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not reset yet, waiting 200ms
hub 1-0:1.0: port 1 not enabled, trying reset again...
hub 1-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?

-- 
uniorg Solutions GmbH - Märkische Strasse 237 - 44141 Dortmund
ffiene@veka.com - Tel:0231-9497-262
--
Ein Unternehmen der uniorg-Gruppe
