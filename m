Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbUDAQSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbUDAQSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:18:13 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:60680 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262945AbUDAQSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:18:12 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.5-rc3-mm4
Date: Thu, 1 Apr 2004 17:32:00 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
References: <20040401020512.0db54102.akpm@osdl.org> <200404011402.44875@WOLK> <20040401151618.GA25910@kroah.com>
In-Reply-To: <20040401151618.GA25910@kroah.com>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404011732.00066@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 17:16, Greg KH wrote:

Hi Greg,

> > Attached are 2 files, one from 2.6.5-rc2-mm5 bk-usb and the other one is 
> > 2.6.5-rc3-mm4 bk-usb. Seems the latter one does not proper init hid though 
> > the module is loaded.
hmm, I was almost quite sure I read hid in lsmod. I've been wrong.

> The hid.ko module was renamed to usbhid.ko.  Are you sure that you are

grmpf. If I had read Documentation/input/input.txt more carefully I'd noticed 
the change myself. Sorry for the noise. Works now.

ciao, Marc

