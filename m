Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbWEaXMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbWEaXMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbWEaXMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:12:45 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:10605 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965242AbWEaXMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:12:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BznJ8XU52SJQ/lqzckDn1Vq8fCi8pBuu3Vimnh2otWLkSpdYL53zrH7NERN8XTsv8nLx6hDb1YWHH8X1TGa1BGqrXCr5tzMkS63VRIsO8seUfApaff5n8/jOop/WOP56FMa2kIMYLi6pncUPlynxwWIx9IAYGPuj9oPUEaFBKnY=
Message-ID: <20f65d530605311612n15820847sca559d0c443fc230@mail.gmail.com>
Date: Thu, 1 Jun 2006 11:12:43 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: IO APIC IRQ assignment
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0606010002200.30170@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
	 <20060530135017.GD5151@harddisk-recovery.com>
	 <20f65d530605300705l60bfcca7k47a41c95bf42a0ef@mail.gmail.com>
	 <Pine.LNX.4.61.0606010002200.30170@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> Plus
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
>
> but I guess you already have these.
>

Yes, I have these options enabled.

*sigh*

Keith
