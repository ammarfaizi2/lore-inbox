Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266537AbSKZSWe>; Tue, 26 Nov 2002 13:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbSKZSWe>; Tue, 26 Nov 2002 13:22:34 -0500
Received: from mnh-1-18.mv.com ([207.22.10.50]:26628 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S266537AbSKZSWd>;
	Tue, 26 Nov 2002 13:22:33 -0500
Message-Id: <200211261833.NAA02294@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: jlnance@unity.ncsu.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.49-1 
In-Reply-To: Your message of "Tue, 26 Nov 2002 09:14:09 EST."
             <20021126141409.GA4589@ncsu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Nov 2002 13:33:03 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu said:
> I think /proc/mm would be better implemented as /dev/mm.

What major and minor numbers should I assign to it?  And what would be
the point of giving it a major and minor, anyway?

				Jeff

