Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264820AbTBTW4D>; Thu, 20 Feb 2003 17:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265807AbTBTW4D>; Thu, 20 Feb 2003 17:56:03 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:42201 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264820AbTBTW4B>; Thu, 20 Feb 2003 17:56:01 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302202306.h1KN66c17134@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.62-ac1
To: szepe@pinerecords.com (Tomas Szepe)
Date: Thu, 20 Feb 2003 18:06:06 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20030220230507.GG1426@louise.pinerecords.com> from "Tomas Szepe" at Feb 21, 2003 12:05:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, this doesn't boot in my vmware setup while 2.5.62 vanilla does
> (same config where applicable).  Never gets to do anything after
> 'Uncompressing Linux... Ok, booting the kernel.'  Any off-hand suspects?

Curious. And its definitely not turned console support back off in the
make config ?

Do you have pretty flashing keyboard lights ?
