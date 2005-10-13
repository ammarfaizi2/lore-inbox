Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbVJMTVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbVJMTVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbVJMTVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:21:44 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:37447 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751630AbVJMTVm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:21:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t1m/TPvx4DzoshzE8zBnP4Oblc0qhCUhJlhzPMUmmbyTvdKde85950h8/rVVmouo4wBSDuq7pr0KcKcV7tidl4aBcli0cyeexPYwZ7MJdl3F/6PeI3Ym2ywb6xJJpci7ShtMv26n2l5biBVO6/43x3ZaAaZKyXxyyQp3U1FDSe8=
Message-ID: <9a8748490510131221q5f70b474o2ea518367c05a609@mail.gmail.com>
Date: Thu, 13 Oct 2005 21:21:41 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/14] Big kfree NULL check cleanup - drivers/scsi
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       "James E.J. Bottomley" <James.Bottomley@steeleye.com>,
       linuxraid@amcc.com, Eric Youngdale <eric@andante.org>,
       Tommy Thorn <Tommy.Thorn@irisa.fr>,
       John Aycock <aycock@cpsc.ucalgary.ca>,
       Russell King <rmk@arm.linux.org.uk>, Oliver Neukum <oliver@neukum.name>,
       Go Taniguchi <go@turbolinux.co.jp>, linux-eata@i-connect.net,
       Dario Ballabio <ballabio_dario@emc.com>,
       Gadi Oxman <gadio@netvision.net.il>, ipslinux@adaptec.com,
       James Smart <james.smart@emulex.com>,
       Atul Mukker <Atul.Mukker@lsil.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Lawrence Foard <entropy@world.std.com>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <200510132122.09667.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510132122.09667.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> This is the drivers/scsi/ part of the big kfree cleanup patch.
>

Whoops, subject on this one is wrong, should have been

[PATCH 07/14] Big kfree NULL check cleanup - drivers/scsi


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
