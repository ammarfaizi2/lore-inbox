Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTKTR2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 12:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTKTR2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 12:28:09 -0500
Received: from amos.sdjls.uniba.sk ([158.195.96.2]:61089 "HELO sturak.sk")
	by vger.kernel.org with SMTP id S262805AbTKTR2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 12:28:04 -0500
From: ceresna@sturak.sk
Date: Thu, 20 Nov 2003 18:27:51 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9-bk22: pmdisk failure on dell latitude
Message-ID: <20031120172751.GA13539@amos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm trying the pmdisk suspend on a Dell Latitude laptop.
All device drivers seem to be suspended correctly,
just at the and a text screen is displayed saying:

  Suspend-To-Disk Failed
  No Suspend to Disk Partions

and after few seconds the laptop reboots.

Strange is, this screen I remember from some older
dell laptop where I was using the APM-bios to do
the suspend. So probably the text screen is displayed
by bios.

Do you have any idea how to overcome this problem?


thanks,
Michal

