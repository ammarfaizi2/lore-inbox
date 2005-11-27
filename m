Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVK0RJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVK0RJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 12:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVK0RJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 12:09:16 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:31588 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751116AbVK0RJP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 12:09:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZBaAbyHTxpNKSi0HqA9OmADHXkqqDMIx4Sw6DPH8/JCl6mzFoa/lCJTMb/s6VDA/0I+WLhs5ffAtQ22cMWokCIePYAucQWO3ooLQk6EYIyBHLotUqlq1rYQnSMMPWmEPWs4VoRArTr9K6oxxl2NJvtquXxVItNk8ReUWbT9fXxU=
Message-ID: <9a8748490511270909o3e0fdd6erdd17d0b6dbd2c36a@mail.gmail.com>
Date: Sun, 27 Nov 2005 18:09:14 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Alternatives to serial console for oops.
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4389D63B.4000702@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4389D63B.4000702@superbug.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/05, James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> Hi,
>
> I wish to view the oops that are normally output on the serial port of
> the PC. The problem I have, is that my PC does not have a serial port.
> Are there any alternatives for getting that vital oops from the kernel
> just as it crashes apart from the serial console.
> Could I get it to use some other interface? e.g. Network interface.
> Parallel port is also not an option.
>
Netconsole (Documentation/networking/netconsole.txt)
Digital camera to take a photo of the screen.
Pen & paper to manually write down the Oops.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
