Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbUJZOnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbUJZOnt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUJZOnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:43:49 -0400
Received: from eta.fastwebnet.it ([213.140.2.50]:9691 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262285AbUJZOlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:41:45 -0400
From: Alessandro Amici <lists@b-open-solutions.it>
Organization: B-Open Solutions srl
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: Is anyone using the load_ramdisk= option in the kernel still?
Date: Tue, 26 Oct 2004 16:41:13 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <clkheo$otl$1@terminus.zytor.com> <200410261603.30707.lists@b-open-solutions.it> <E1CMS1A-0001F5-00@chiark.greenend.org.uk>
In-Reply-To: <E1CMS1A-0001F5-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410261641.13052.lists@b-open-solutions.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew,

On Tuesday 26 October 2004 16:09, Matthew Garrett wrote:
> Alessandro Amici <lists@b-open-solutions.it> wrote:
> > On Tuesday 26 October 2004 05:48, H. Peter Anvin wrote:
> >> a) Does anyone use the load_ramdisk= option anymore, or is it
> >> legitimate to drop?
> >
> > I'm pretty sure it is used by the Debian installer when bootstrapping
> > from a floppy, but...
>
> I believe that this is no longer the case with the new installer.

If you have the root filesystem on a floppy you still need load_ramdisk 
(checked a few days ago ;)

cheers,
alessandro
