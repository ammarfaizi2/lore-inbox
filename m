Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVFIOtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVFIOtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 10:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVFIOtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 10:49:32 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:60907 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261424AbVFIOt1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 10:49:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fp82jui6VxfMjYwFJ7W0AnVPTp8OfPU47+VH6j8FbumWPDNZrzdPbknBDIun+sUFhS1auw0Bh+h99u2gWTFS2FxZ7TpBcRU/XRWZ9IxVu3oDXqvhsv8sHuAGNT27GiLaGy2bl217ubnOtZEG1h/RVHO97AMc1RPB0PVoX4N6Wi0=
Message-ID: <396a6e000506090749265a5066@mail.gmail.com>
Date: Thu, 9 Jun 2005 17:49:26 +0300
From: kenoti maembe <kenotimaembe@gmail.com>
Reply-To: kenoti maembe <kenotimaembe@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Virtual Terminal switching problem with a 2.6.10 kernel with a ruby patch
In-Reply-To: <396a6e00050608091524b97479@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <396a6e00050608091524b97479@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am working on a dual head project for my final year project at the
university of nairobi in kenya and come across a discussion where it
was stated that the linux kernel (by then 2.4) does not allow for two
or more virtual terminals to exist concurrently..I have a few
questions I would like to ask
1.  Is this still the case with the 2.6 kernel? Thought of working
through these by creating a new XFree86 and using the XFree86
prefbusid patch from.from http://www.ltn.lv/~aivils/ bt still only one
vt works at a time.
2. Have tried to assign devices to the different vts but cant seemt to
get a way to assign the usb keyboard.All input device modules and usb
modules are load in the kernel so dont understand what the issue is.

CPU: Athlon 1200+
RAM: 384Mb
Videocards: NVIDIA GeForce4 MX 440 (AGP), S3 Tio (PCI)
Motherboard: Via
Keyboards: one PS/2 keyboards, one USB keyboard
Mice: one serial, one USB
Monitors: 17'', 15''
on a mandrake 10.0

Thank you all.
