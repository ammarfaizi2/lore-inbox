Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSK0D4D>; Tue, 26 Nov 2002 22:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSK0D4D>; Tue, 26 Nov 2002 22:56:03 -0500
Received: from mnh-1-27.mv.com ([207.22.10.59]:44292 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261518AbSK0D4C>;
	Tue, 26 Nov 2002 22:56:02 -0500
Message-Id: <200211270406.XAA04379@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.49-1 
In-Reply-To: Your message of "26 Nov 2002 18:29:15 PST."
             <as1alr$1bs$1@cesium.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Nov 2002 23:06:50 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com said:
> Access control, ability to work in a chroot, ...

Point.

> For major/minor, this is presumably a misc device (major 10) or, if
> you don't need module support, a kernel core device (major 1), and
> write to device@lanana.org to have a minor number assigned. 

If you think that this would be better as a misc device than a proc entry,
then I can certainly go along with that.

				Jeff

