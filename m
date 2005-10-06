Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVJFWQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVJFWQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 18:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVJFWQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 18:16:44 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:40045 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750855AbVJFWQn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 18:16:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hn4vmPEUdl3aklrUrSN+xRId2zbJ0HHV7EG+4zZnlAQZDwKJAkYo7KBlSgSS3toKEx3B+2QK/3BJXgoguClJ/lgeAMkfNjs9SAeyXxdWeIpn0sNpUtCsIQbtC40Iy43ZMguKg3fYQ72liTO3qc8UYwgcD7d2/opkUAagt5Y2/v0=
Message-ID: <4af2d03a0510061516t32a62180t380dcb856d45a774@mail.gmail.com>
Date: Fri, 7 Oct 2005 00:16:42 +0200
From: Jiri Slaby <jirislaby@gmail.com>
Reply-To: Jiri Slaby <jirislaby@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/10] drivers/char: pci_find_device remove (drivers/char/ip2main.c)
Cc: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, mhw@wittsend.com
In-Reply-To: <4324B5B3.6080703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509101221.j8ACL8oq017230@localhost.localdomain>
	 <43233F48.6060406@gmail.com> <4324B5B3.6080703@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> Jiri Slaby napsal(a):
>
> > Cc: mhw@wittsend.com [maintainer]
>
> Hello.
>
> Is drivers/char/ip2main.c still maintained? Are you going to rewrite
> this driver to 2.6 API (PCI probing etc.)?
It seems, like it isn't, last chance to respond, otherwise the driver
becomes unmaintained (let's say on 12 Oct).

thanks,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
