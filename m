Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVCIQn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVCIQn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVCIQnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:43:25 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:63463 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261642AbVCIQnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:43:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QCmm8P2tNaCyuQEvZLNubHo2xjiTN9z0YjKHPpZxreoBtAo+G2MeaL0Ex48G+w/VqjBokrOxgBO1z2/Bjx7DM6dY585wqYG0+U2/SW1s7gl4hi23ULNwSm5t0R0Q/kF4MIY/pxEYalkD7ce3e1N/h+fMAWOioNVlqtfthMUc3I8=
Message-ID: <58cb370e050309084374f93a71@mail.gmail.com>
Date: Wed, 9 Mar 2005 17:43:02 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.11-ac1
Cc: CaT <cat@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110386321.3116.196.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1110231261.3116.90.camel@localhost.localdomain>
	 <20050309072646.GG1811@zip.com.au>
	 <58cb370e05030908267f0fadbe@mail.gmail.com>
	 <1110386321.3116.196.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2005 16:38:43 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-03-09 at 16:26, Bartlomiej Zolnierkiewicz wrote:
> > It can be merged if somebody fix it to always force controller into
> > non-RAID mode and remove RAID mode support (which currently
> > does nothing more besides complicating the driver and making special
> > commands unusable).
> 
> Incorrect

Very helpful
