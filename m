Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVJGNWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVJGNWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVJGNWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:22:30 -0400
Received: from web30515.mail.mud.yahoo.com ([68.142.201.243]:12131 "HELO
	web30515.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932545AbVJGNWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:22:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mQTa7hjSUIDzdFMUOD/ueixv3mDjG0xkHKWRqrliXeFRUAgxPIyz3RRzUznJgyRsWo6rz9JXjHNPMOvU+nVRvZp7lFpLeWuYktegdNncrFsH5iUoIVQNy4twyEfINetScTwPJTop5G5yLMgToUAbxDgPjsJgb+fuiQuVcjXRJJM=  ;
Message-ID: <20051007132227.15252.qmail@web30515.mail.mud.yahoo.com>
Date: Fri, 7 Oct 2005 09:22:27 -0400 (EDT)
From: Arthur Cosma <tux_fan@yahoo.ca>
Subject: Re: Any news on PATA support for Promise PDC 20375?
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <4342AF23.6000907@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

Thank you very much for taking the time to reply to my
inquiry. Although I didn't get the attachment, I won't
bother you to re-send, I will try to find it in the
Gentoo kernel. If that fails, I will wait for a
release.

Best regards,
Arthur

--- Daniel Drake <dsd@gentoo.org> wrote:

> Arthur Cosma wrote:
> > Please CC me only any reply to this message, as I
> am not a mailing list
> > subscriber.
> > 
> > This was my last resort, as all searches on the
> subject topic yield
> > messages from 2004, many of which mention Jeff
> Garzik's name.
> > 
> > After trying 2.6.13.2, I still don't get the PATA
> drives recognized, so I
> > believe it's still not there yet.
> > 
> > The question is, will it ever be, or has it been
> dropped?
> 
> I'm attaching the patch included in Gentoo's 2.6.13
> kernels, which originally
> came from Jeff's repo.
> 
> I asked Jeff about this patch previously, and his
> comment was:
> 
> > However, this patch in particular is safe and OK
> -- it just needs cleaning
> > up before including in 2.6.13, and I haven't
> figured out how to clean it up
> > yet.  The port_flags[] array this patch adds is a
> hack.
> > 
> > I need to separate the port settings from the host
> settings, which would be
> > the proper fix.
> 
> So I guess the answer is just wait a while longer
> (and patch manually for now) :)
> 
> Daniel
> 



	

	
		
__________________________________________________________ 
Find your next car at http://autos.yahoo.ca
