Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUH0W2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUH0W2d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUH0W1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 18:27:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34970 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264389AbUH0WW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 18:22:26 -0400
Message-ID: <412FB418.1030508@pobox.com>
Date: Fri, 27 Aug 2004 18:22:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Anton Altaparmakov <aia21@cam.ac.uk>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Craig Milo Rogers <rogers@isi.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webcam@smcc.demon.nl
Subject: Re: Termination of the Philips Webcam Driver (pwc)
References: <20040826233244.GA1284@isi.edu>  <20040827004757.A26095@infradead.org>  <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org>  <20040827094346.B29407@infradead.org>  <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales> <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org> <Pine.LNX.4.60.0408272225140.9310@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0408271448400.14196@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408271448400.14196@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Firmware on a device is logically equivalent to the kernel running on
> another machine entirely.

Yup.

In that fact's what a lot of modern RAID firmwares are, an RTOS running 
on a generic CPU.  Some NIC firmwares too.

	Jeff


