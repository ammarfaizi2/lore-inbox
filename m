Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUHRTEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUHRTEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 15:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUHRTEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 15:04:37 -0400
Received: from mr04.conversent.net ([155.212.2.21]:30166 "EHLO
	mr04.conversent.net") by vger.kernel.org with ESMTP id S267502AbUHRTEf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 15:04:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Is it possible to have a Kernel & initrd in 1 binary?
Date: Wed, 18 Aug 2004 15:04:31 -0400
Message-ID: <E8F8DBCB0468204E856114A2CD20741F1A9309@mail.local.ActualitySystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is it possible to have a Kernel & initrd in 1 binary?
thread-index: AcSFVGHLXxO2TUubTEeIuRikVnOG5AAAYTLA
From: "Dave Aubin" <daubin@actuality-systems.com>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Chris,

  Yes, that's the stuff.  I am at a loss finding
any detailed how to's or what have you.  I'm looking 
for a little bit more.  A simple tutorial would be awesome! 
Can anyone point me as to where to find more info on
Initramfs?

Thanks again,
Dave

-----Original Message-----
From: Chris Wedgwood [mailto:cw@f00f.org] 
Sent: Wednesday, August 18, 2004 2:52 PM
To: Dave Aubin
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is it possible to have a Kernel & initrd in 1 binary?

On Wed, Aug 18, 2004 at 02:32:07PM -0400, Dave Aubin wrote:

> Question, is there a way to bundle both the kernel and initrd in to 
> just a kernel binary?

see the initramfs stuff in linux/usr


  --cw


