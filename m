Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUAJXxE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 18:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265707AbUAJXxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 18:53:04 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:58500 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265701AbUAJXxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 18:53:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>
Subject: Re: Do not use synaptics extensions by default
Date: Sat, 10 Jan 2004 18:52:56 -0500
User-Agent: KMail/1.5.4
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
References: <20040110175930.GA1749@elf.ucw.cz> <20040110201057.GA1367@elf.ucw.cz> <20040110201512.GA23208@ucw.cz>
In-Reply-To: <20040110201512.GA23208@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101852.56429.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 03:15 pm, Vojtech Pavlik wrote:
> On Sat, Jan 10, 2004 at 09:10:58PM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > > > Why would you document something that is deprecated? It was
> > > > > removed so the new users would not start using it instead of
> > > > > psmouse.proto. psmouse.noext should be gone soon.
> > > >
> > > > My understanding is that Documentation/kernel-parameters.txt
> > > > should document all available parameters...
> > >
> > > Well, I wouldn't mind documenting psmouse.noext, with a comment
> > > that it shouldn't be used because it'll be removed in near future.
> >
> > AFAICS, it is still psmouse*_*noext in mainline kernel, so this
> > should be correct...
> >
> > 								Pavel
>
> No problem with this patch, though it'd be better if you could provide
> it against the -mm kernel for Andrew.
>

In Andrew's tree noext option is already gone.

Dmitry
