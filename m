Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSKKMhO>; Mon, 11 Nov 2002 07:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264709AbSKKMhO>; Mon, 11 Nov 2002 07:37:14 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:29859 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264705AbSKKMhM>; Mon, 11 Nov 2002 07:37:12 -0500
Subject: Re: [PATCH] sysfs stuff for eisa bus [1/3]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mzyngier@freesurf.fr
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
In-Reply-To: <wrpwunkfq8m.fsf@hina.wild-wind.fr.eu.org>
References: <wrpbs4xgke4.fsf@hina.wild-wind.fr.eu.org>
	<20021110233206.GA3988@win.tue.nl> 
	<wrpwunkfq8m.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 13:08:34 +0000
Message-Id: <1037020114.2887.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 08:46, Marc Zyngier wrote:
> Andries> What use is a very long and very incomplete list?
> 
> A big part of this database contains in fact ISA cards for which an
> EISA config file exists. So it could be trimmed down to 50%, I think.
> I was thinking the database could be useful for ISAPNP (since it uses
> the same IDs).

I think a ".ids" file list is valuable. It can be used for things like
EISA card identification obviously but it also has a big value for
"lseisa" "lspnp" and friends (and hopefully when someone fixes the
device model "lsdev"


Alan

