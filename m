Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266586AbRGXCOB>; Mon, 23 Jul 2001 22:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266738AbRGXCNv>; Mon, 23 Jul 2001 22:13:51 -0400
Received: from rj.sgi.com ([204.94.215.100]:45455 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S266586AbRGXCNm>;
	Mon, 23 Jul 2001 22:13:42 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
cc: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control 
In-Reply-To: Your message of "Mon, 23 Jul 2001 23:06:34 +0200."
             <3B5C91DA.3C8073AC@wanadoo.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Jul 2001 12:13:31 +1000
Message-ID: <22204.995940811@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001 23:06:34 +0200, 
Jerome de Vivie <jerome.de-vivie@wanadoo.fr> wrote:
>Handling multiples versions is a tough challenge (...even in the linux
>kernel). Working under software configuration management (SCM) helps
>but with some overhead; and it works only if everybody support it.

FYI, you do not need this for the kernel.  kbuild 2.5 already supports
multiple source trees for building the linux kernel.  Current beta is
http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-2.4.7-2.gz, read
Documentation/kbuild/kbuild-2.5.txt.

