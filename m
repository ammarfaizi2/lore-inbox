Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSEaSoG>; Fri, 31 May 2002 14:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSEaSoF>; Fri, 31 May 2002 14:44:05 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:56741 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S316574AbSEaSoF>; Fri, 31 May 2002 14:44:05 -0400
Date: Fri, 31 May 2002 20:43:51 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB host drivers test results (2.5.19) and problem.
Message-ID: <20020531184350.GA10621@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020531133429.GF8310@come.alcove-fr> <20020531163836.GA1250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 09:38:36AM -0700, Greg KH wrote:

> > 2 When doing a rmmod on one of the two last drivers, 
> > the kernel oopses with a (hand copied trace):
> 
> If you remove _any_ pci driver module from 2.5.19 you get an oops, this
> isn't limited to the USB drivers right now :)

Yep, I saw that afterwards when shutting down my laptop.

Sorry for having incriminated the USB subsystem for that :-)

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
