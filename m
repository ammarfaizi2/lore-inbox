Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbUJXNKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbUJXNKn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUJXNKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:10:42 -0400
Received: from services.exanet.com ([212.143.73.102]:33104 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S261470AbUJXNIb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:08:31 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: PATCH: (as189) Fix incorrect Appletalk DDP multicast address
Date: Sun, 24 Oct 2004 15:08:29 +0200
Message-ID: <F8B4823728281C429F53D71695A3AA1E01272A45@hawk.exanet-il.co.il>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH: (as189) Fix incorrect Appletalk DDP multicast address
Thread-Index: AcSrBZ68nhvuRJwES2Kl1IRBehP9XQOxMxWg
From: "Shlomi Yaakobovich" <Shlomi@exanet.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>, <acme@conectiva.com.br>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Has anyone looked at this ?  Can we expect to see these changes in the next 2.4.x and 2.6.x ?

Thanks,
Shlomi

> -----Original Message-----
> From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com]
> Sent: Tuesday, October 05, 2004 2:56 PM
> To: Shlomi Yaakobovich; acme@conectiva.com.br
> Cc: linux-kernel
> Subject: Re: PATCH: (as189) Fix incorrect Appletalk DDP 
> multicast address
> 
> 
> 
> Arnaldo, 
> 
> Can you take care of this for us?
> 
> 
> On Sun, Oct 03, 2004 at 09:50:44AM +0200, Shlomi Yaakobovich wrote:
> > Hi all,
> > 
> > Does anyone know what happened to the patch proposed by Alan Stern:
> > 
> > 	http://www.ussg.iu.edu/hypermail/linux/kernel/0402.1/1147.html
> > 
> > I looked at the latest sources of 2.4 and 2.6 and this 
> patch was not applied to them. Was there a specific reason, 
> was this patch not tested or found buggy ?  
> > I believe I have encountered a bug in the system I'm 
> running that is related to this, I found this by accident 
> when debugging appletalk, and found out that someone already 
> >saw this...
> > 
> > Can this patch be applied to the next kernel build ?  I 
> noticed that it was only for 2.6, I can create a similar 
> patch for 2.4 if needed, I just need to know if there was 
> something wrong with it.
> 
