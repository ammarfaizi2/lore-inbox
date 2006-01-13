Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWAMKnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWAMKnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWAMKnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:43:32 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:62562 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964819AbWAMKnc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:43:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O/AmlyuXRGXvYSeYwOC1FqP8/3XiwNTJgxoLUYvwpiPihecXYiahaZYOXj+dTp3EcbHZF3prJ5evZyPT6NlOViLZmtf/0ly8bXHV2wVhhTivgEkCy3VQAxE406BWm+L/JfjC1rvnymbL6+VkC40X2fzK/thGWLIrYPNiBIziPgw=
Message-ID: <1e62d1370601130243r584eb6e2u57a4e7280f493d97@mail.gmail.com>
Date: Fri, 13 Jan 2006 15:43:30 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Is there any hard disk standard?
Cc: jeff shia <tshxiayu@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0601130211j50b85af0w3fa2a1a5f872d0e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7cd5d4b40601130200m73798389p4939e9e43cb0db87@mail.gmail.com>
	 <58cb370e0601130211j50b85af0w3fa2a1a5f872d0e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 1/13/06, jeff shia <tshxiayu@gmail.com> wrote:
> >
> > Many companies produce hard disks,Is there any hard disk standard?Or
> > where can I
> > get the standard?
>
> ATA: http://www.t13.org (seems to be down at the moment)
> SCSI: http://www.t10.org
> SerialATA: http://www.serialata.org
>
> or use www.google.com

Adding some explanation in Bartlomiej reply :

The standards are related to bus on which the device (hard disk in
your case) are attached ! As HDD can be connected to IDE/ATA, SCSI or
SATA or so on .... so they are the standard for connectivity between
the device and system ... And the device (like HDD) need to provide
that standard interface for connectivity but can do what-ever they
like internally through its firmware or driver (CMIIW)

--
Fawad Lateef
