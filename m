Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUBRMfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266501AbUBRMfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:35:11 -0500
Received: from [212.28.208.94] ([212.28.208.94]:38159 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266457AbUBRMfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:35:04 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Date: Wed, 18 Feb 2004 13:34:56 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402181259.40840.robin.rosenberg.lists@dewire.com> <20040218120558.GA13944@louise.pinerecords.com>
In-Reply-To: <20040218120558.GA13944@louise.pinerecords.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402181334.56096.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 February 2004 13.05, Tomas Szepe wrote:
> On Feb-18 2004, Wed, 12:59 +0100
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> 
> > On Wednesday 18 February 2004 12.49, Tomas Szepe wrote:
> > > Would you _please_ read the lkml FAQ and stop posting e-mails with lines
> > > longer than 80 characters?  Thank you.
> > 
> > As soon as someone asks nicely...  I thought any decent mail client simply
> > wrapped the lines.
> 
> 1)  Quite the contrary.  Any _decent_ mail client will _not_ wrap the lines.
>
> 2)  A mail client that will wrap the lines will make your posts look like 
this:
> 
> <cut>
> Having to put up with the existence of Windows day in and out is the reason 
I'm
> still on
> an eight-bit encoding.  Sorry for not explaining the REAL problem, but only 
a
> partial
> problem. I need to support all kinds of clients on Windows with protocols 
that  
> convey no
> character set info. With samba that's no problem. Having to put up with a 
Unix
> world running
> <cut>

That's what happens when the sender wraps the lines at column 80 and your 
client wraps at 72 (or similar situation), just another reason not to wrap 
when sending and let the users  client do whatever the user think is fine.

In order not to wrap and destroy information I have the autowrap feature off 
when composing mail, becase wrapped and cut stack traces, cuts from log files 
etc are a pain. 

BTW The 80 character rule is only mention wrt to signatures.

-- robin
