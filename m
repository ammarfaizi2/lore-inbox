Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280035AbRK2Qta>; Thu, 29 Nov 2001 11:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283322AbRK2QtU>; Thu, 29 Nov 2001 11:49:20 -0500
Received: from okcforum.org ([207.43.150.207]:33797 "EHLO okcforum.org")
	by vger.kernel.org with ESMTP id <S280035AbRK2QtB>;
	Thu, 29 Nov 2001 11:49:01 -0500
Subject: Re: Unresponiveness of 2.4.16 revisited
From: "Nathan G. Grennan" <ngrennan@okcforum.org>
To: Oktay Akbal <oktay.akbal@s-tec.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0111291030390.1191-100000@omega.hbh.net>
In-Reply-To: <Pine.LNX.4.42.0111291030390.1191-100000@omega.hbh.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 29 Nov 2001 10:48:32 -0600
Message-Id: <1007052513.1470.5.camel@cygnusx-1.okcforum.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-29 at 03:32, Oktay Akbal wrote:
> On 29 Nov 2001, Nathan G. Grennan wrote:
> 
> > ok, I doubled checked things. It seems mounting an ext3 filesystem as
> > ext2 is somewhat a myth. If the kernel supports ext3 it still mounts it
> > as ext3 even if /etc/fstab says ext2. 
> 
> really on other partitions than root-fs ?
> 
> -- 
> Oktay Akbal

I am not positive about mounting non-root filesystems. I would suspect
it is just a problem with root filesystems.

