Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVJFWUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVJFWUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 18:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVJFWUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 18:20:23 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:48545 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750951AbVJFWUX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 18:20:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BDusENkBuXwBgjv0rIB0HuB2/M+O1pbHFYLPkaVZSWQ8us4QLbRmCh5f0vF4mkBvU48nfnhIvq0SMiyGG96PUQO2Se9vpJlCeq+wRX00yul+En2BFtz9nyK78DHwf9JV0MIE3ATW4etCTt5LAPHu/Ohx6kA5qM/5mUPj9EERYo8=
Message-ID: <4af2d03a0510061520p7d2abe55me35cdee6ac57c460@mail.gmail.com>
Date: Fri, 7 Oct 2005 00:20:22 +0200
From: Jiri Slaby <jirislaby@gmail.com>
Reply-To: Jiri Slaby <jirislaby@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 5/10] drivers/char: pci_find_device remove (drivers/char/specialix.c)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       R.E.Wolff@bitwizard.nl
In-Reply-To: <43233FEC.2020802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509101221.j8ACL9XI017246@localhost.localdomain>
	 <43233FEC.2020802@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> Cc: R.E.Wolff@BitWizard.nl [maintainer]
Hello.

Is drivers/char/ip2main.c still maintained? Are you going to rewrite
this driver to 2.6 API (PCI probing etc.)?

thanks,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10
