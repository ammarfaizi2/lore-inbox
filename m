Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288782AbSAJMLd>; Thu, 10 Jan 2002 07:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288786AbSAJMLX>; Thu, 10 Jan 2002 07:11:23 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:3594 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288782AbSAJMLS>;
	Thu, 10 Jan 2002 07:11:18 -0500
Date: Thu, 10 Jan 2002 10:11:07 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Jim Crilly <noth@noth.is.eleet.ca>
Cc: Chris Ball <chris@void.printf.net>, Benjamin S Carrell <ben@xmission.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Bigggg Maxtor drives (fwd)
In-Reply-To: <3C3D191E.7090804@noth.is.eleet.ca>
Message-ID: <Pine.LNX.4.33L.0201101010090.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Jim Crilly wrote:

> Actually it would seem this is just Andre's, not so subtle, way of
> trying to prove that his ATA133/48-bit addressing patches need
> included in 2.4.

I think you'll agree with him the moment you end up with
a cheap 160 GB drive in your machine and the old driver
(which is limited to 32(?)-bit LBA) won't let you use a
large portion of the disk ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

