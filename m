Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289255AbSAVKyH>; Tue, 22 Jan 2002 05:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289270AbSAVKx4>; Tue, 22 Jan 2002 05:53:56 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:7940 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289255AbSAVKxk>;
	Tue, 22 Jan 2002 05:53:40 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Giacomo Catenazzi <cate@debian.org>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: CML2-2.1.3 is available 
In-Reply-To: Your message of "Tue, 22 Jan 2002 11:48:06 BST."
             <3C4D4366.9020406@debian.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Jan 2002 21:53:22 +1100
Message-ID: <15543.1011696802@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002 11:48:06 +0100, 
Giacomo Catenazzi <cate@debian.org> wrote:
>My question: where do you find
>
>autoconf autoconfigure: symlinks
>    $(SHELL_SCRIPT) script/...

You don't.  That was an example of how you can have multiple targets
pointing to the same code, it is not in kbuild yet.

>BTW: I used 'make autoprobe' because of possible confutions, in
>latter version. Now Eric will use both 'make autoconfig' and
>'make autoprobe'.

FWIW, I prefer autoprobe.

