Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVBCAQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVBCAQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVBCAOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:14:00 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:48248 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262562AbVBCAFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:05:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OQTJNG4/305yCOoIJ7X1AGJHvWaYrdf6AWBegk9FRXxSWk/g0K9RLc+2tOLfyHal0atf2O+s82F2yi9ALZxAkTAS9qkYBSB3nsfmfrNz4iyDrm1M1u2mD8LkojpB+a2Do40JXzgpPsnodRFUzO1Zrs4im7d/qRaeVnUR7upcDIc=
Message-ID: <58cb370e05020216055ad338ed@mail.gmail.com>
Date: Thu, 3 Feb 2005 01:05:23 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 03/29] ide: cleanup opti621
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <20050202024538.GD621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202024538.GD621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:45:38 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 03_ide_cleanup_opti621.patch
> >
> >       In drivers/ide/pci/opti612.[hc], init_setup_opt621() is
> >       declared, defined and referenced but never actullay used.
> >       Thie patch removes the function.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
