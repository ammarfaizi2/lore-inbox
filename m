Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283050AbRLDLfN>; Tue, 4 Dec 2001 06:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282396AbRLDLfD>; Tue, 4 Dec 2001 06:35:03 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:3771 "EHLO due.stud.ntnu.no")
	by vger.kernel.org with ESMTP id <S283058AbRLDLev>;
	Tue, 4 Dec 2001 06:34:51 -0500
Date: Tue, 4 Dec 2001 12:34:46 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <thomas@langaas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro  -- clusters
Message-ID: <20011204123446.A31017@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011204103010.A30650@stud.ntnu.no> <E16BC8s-0001Tf-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16BC8s-0001Tf-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 04, 2001 at 09:45:34AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> > So there's someone fixing the SCSI-layer code now?   (It's marked as
> > unmaintained in the MAINTAINERS-file for 2.4-kernels, at least)
> Take a look at the 2.5 code and you'll notice various bits of old cruft
> are vanishing rapidly (old eh support, clustering gloop etc)

Ok, I see... I'm trying to read up on the design of the SCSI-internals (from
http://www.andante.org/scsi.html), and it seems like there's much to do
yet... Is the listing in scsi_todo.html still valid, or is much of what's
listed there already done?

-- 
Thomas
