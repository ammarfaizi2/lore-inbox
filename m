Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273912AbRJPIMG>; Tue, 16 Oct 2001 04:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273877AbRJPIL4>; Tue, 16 Oct 2001 04:11:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7946 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273870AbRJPILw>; Tue, 16 Oct 2001 04:11:52 -0400
Subject: Re: What is /boot/modules-info
To: kaos@ocs.com.au (Keith Owens)
Date: Tue, 16 Oct 2001 09:17:25 +0100 (BST)
Cc: mra@pobox.com (Mark Atwood), linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20038.1003207416@kao2.melbourne.sgi.com> from "Keith Owens" at Oct 16, 2001 02:43:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15tPPh-00051D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 15 Oct 2001 12:40:53 -0700, 
> Mark Atwood <mra@pobox.com> wrote:
> >I've been doing some online searching, and the best I can find is it
> >is an exampe of a RPM resource, and no one can figure out what it's
> >for.
> 
> A Redhat'ism, nothing in the standard kernel or modutils uses it.  Ask RH.

Its a table of drivers, arguments to the module etc for common modules,
used by the various config tools to help guide installs etc
