Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUBEKTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbUBEKTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:19:36 -0500
Received: from mail.veka.com ([213.68.6.130]:4332 "EHLO mail.veka.com")
	by vger.kernel.org with ESMTP id S265056AbUBEKTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:19:34 -0500
From: Frank Fiene <ff@veka.com>
Organization: VEKA AG
To: linux-kernel@vger.kernel.org
Subject: USB mouse doesn't work since 2.6.2-rc3
Date: Thu, 5 Feb 2004 11:19:33 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Message-Id: <200402051119.33092.ff@veka.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Logitech Optical Trackman and it worked fine with versions < 
2.6.2-rc3.

The command "lsusb" shows me only the hubs but no connected USB gadget.
Must i upgrade tools, libs, ... for the latest kernel?
My system is a Thinkpad A31p with SuSE 9 and following usb rpms:
usbutils-0.11-124
libusb-0.1.8beta-35

I've tried 2.6.2-rc3 and 2.6.2-vanilla.

Please help.
Regards, Frank.
-- 
uniorg Solutions GmbH - Märkische Strasse 237 - 44141 Dortmund
ffiene@veka.com - Tel:0231-9497-262
--
Ein Unternehmen der uniorg-Gruppe
