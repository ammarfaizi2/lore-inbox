Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTJOPwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTJOPwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:52:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54913 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263466AbTJOPwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:52:30 -0400
Date: Wed, 15 Oct 2003 11:54:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Nikita Danilov <Nikita@Namesys.COM>
cc: Erik Mouw <erik@harddisk-recovery.com>, Josh Litherland <josh@temp123.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS
In-Reply-To: <16269.23199.833564.163986@laputa.namesys.com>
Message-ID: <Pine.LNX.4.53.0310151150370.7350@chaos>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl>
 <16269.20654.201680.390284@laputa.namesys.com> <20031015142738.GG24799@bitwizard.nl>
 <16269.23199.833564.163986@laputa.namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Nikita Danilov wrote:

> Erik Mouw writes:
>  > On Wed, Oct 15, 2003 at 05:50:38PM +0400, Nikita Danilov wrote:
>  > > Erik Mouw writes:
>  > >  > Nowadays disks are so incredibly cheap, that transparent compression
>  > >  > support is not realy worth it anymore (IMHO).
>  > >
[SNIPPED...]

>  >
>  > PS: let me guess: among other things, reiser4 comes with transparent
>  >     compression? ;-)
>
> Yes, it will.
>

EeeeeeK!  A single bad sector could prevent an entire database from
being uncompressed! You may want to re-think that idea before you
commit a lot of time to it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


