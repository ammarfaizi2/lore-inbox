Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317467AbSF1U2V>; Fri, 28 Jun 2002 16:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317475AbSF1U2U>; Fri, 28 Jun 2002 16:28:20 -0400
Received: from congress104.linuxsymposium.org ([209.151.18.104]:7296 "EHLO
	karaya.com") by vger.kernel.org with ESMTP id <S317467AbSF1U2U>;
	Fri, 28 Jun 2002 16:28:20 -0400
Message-Id: <200206282032.g5SKW4r02727@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Serge van den Boom <svdb@stack.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: On the forgotten ptrace EIP bug (patch included) 
In-Reply-To: Your message of "Fri, 28 Jun 2002 17:24:41 +0200."
             <20020628144639.I51309-100000@toad.stack.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Jun 2002 16:32:04 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

svdb@stack.nl said:
> At any rate, I have successfully booted a UML kernel, with either
> patch applied to the host system kernel.

Hmmm, well as long as your current patch doesn't break UML, then I can't
have any objection to it.  It's puzzling that the old patch didn't break it
though.  Maybe I'm mixing up ptrace patches or something.

				Jeff

