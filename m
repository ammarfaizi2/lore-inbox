Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288814AbSAIROG>; Wed, 9 Jan 2002 12:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSAIRNw>; Wed, 9 Jan 2002 12:13:52 -0500
Received: from web14906.mail.yahoo.com ([216.136.225.58]:64772 "HELO
	web14906.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288814AbSAIRNQ>; Wed, 9 Jan 2002 12:13:16 -0500
Message-ID: <20020109171315.71461.qmail@web14906.mail.yahoo.com>
Date: Wed, 9 Jan 2002 12:13:15 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Re: About Loop Device
To: Doug McNaught <doug@wireboard.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
In-Reply-To: <m3r8oz8ngr.fsf@varsoon.denali.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you explain that detailed for me? I mean the whole
command I can use to connect the loop device and the
floppy disk.

Thanks.

Michael


--- Doug McNaught <doug@wireboard.com> wrote:
> Michael Zhu <mylinuxk@yahoo.ca> writes:
> 
> > Thanks for the reply. But when I try to use the
> > command "mount -o loop /dev/fd0 /floppy", the
> mount
> > returns an error saying "mount: you must specify
> the
> > filesystem type". What is wrong? Thanks.
> 
> You probably want losetup(8) instead of mount.
> 
> -Doug
> -- 
> Let us cross over the river, and rest under the
> shade of the trees.
>    --T. J. Jackson, 1863


______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
