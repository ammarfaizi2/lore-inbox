Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADF2l>; Thu, 4 Jan 2001 00:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132754AbRADF2c>; Thu, 4 Jan 2001 00:28:32 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:55062 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129324AbRADF2U>; Thu, 4 Jan 2001 00:28:20 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Frank Davis <fdavis112@juno.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-prerelease-ac5 : 'make dep' error 
In-Reply-To: Your message of "Wed, 03 Jan 2001 23:51:31 CDT."
             <20010103.235132.-322857.2.fdavis112@juno.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jan 2001 16:28:12 +1100
Message-ID: <22515.978586092@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001 23:51:31 -0500, 
Frank Davis <fdavis112@juno.com> wrote:
>Hello,
>       I received the following make dep error while compiling
>prerelease-ac5 .
>make -C acpi fastdep
>make[4]: Entering directory `/usr/src/linux/drivers/acpi'
>/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS' references
>itself (eventually).  Stop.

Which version of make are you running, make --version?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
