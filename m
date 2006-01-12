Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161236AbWALULU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161236AbWALULU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWALULU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:11:20 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:14262 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1161236AbWALULT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:11:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Place for userland swsusp parts
Date: Thu, 12 Jan 2006 21:13:24 +0100
User-Agent: KMail/1.9
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060111221511.GA8223@elf.ucw.cz> <200601120819.42512.ncunningham@linuxmail.org> <20060112143851.GB9752@elf.ucw.cz>
In-Reply-To: <20060112143851.GB9752@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601122113.24461.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 12 January 2006 15:38, Pavel Machek wrote:
> On Čt 12-01-06 08:19:42, Nigel Cunningham wrote:
> > On Thursday 12 January 2006 08:15, Pavel Machek wrote:
> > > Is there some place where we could  put userland swsusp parts under
> > > version control?
> > >
> > > swsusp.sf.net looks like possible place, but it has been in use by
> > > suspend2... Is it still being used? If not, would it be possible to
> > > "hijack" it for swsusp development?
> > 
> > It's not still being used (we have suspend2.net now). The only problem I see 
> > with that is that it still has all the old suspend2 stuff and Sourceforge 
> > make it really hard to clear out a project's files. You were talking about 
> > calling it uswsusp or something like that. How about starting a 
> > uswsusp.sf.net?
> 
> Rafael, do you have repository to place userland parts in, or should I
> start uswsusp.sf.net project, or do you want to do it?

I think I can host them (the box is moving tomorrow, hopefully, so it should get
enough bandwidth ;-)), but I'm afraid I won't have time to set up a mailing list
etc.

IMHO uswsusp.sf.net would be too similar to swsusp.sf.net, especially that
swsusp.sf.net is redirected to www.suspend2.net.

Greetings,
Rafael
