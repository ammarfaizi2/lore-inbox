Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289699AbSAOWIE>; Tue, 15 Jan 2002 17:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289698AbSAOWHy>; Tue, 15 Jan 2002 17:07:54 -0500
Received: from air-1.osdl.org ([65.201.151.5]:59273 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S289697AbSAOWHq>;
	Tue, 15 Jan 2002 17:07:46 -0500
Date: Tue, 15 Jan 2002 14:09:27 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Nicolas Pitre <nico@cam.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Why not "attach" patches?
In-Reply-To: <Pine.LNX.4.33.0201151448050.5892-100000@xanadu.home>
Message-ID: <Pine.LNX.4.33.0201151405250.9053-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Jan 2002, Nicolas Pitre wrote:

> On Tue, 15 Jan 2002, Alan Cox wrote:
>
> > BTW: If you are sending me anything DO use attachments. Especially if you
> > use any of the following, which seem to have some versions that mangle
> > inline diffs
> >
> > 	Lotus Notes
> > 	Pine
> > 	Kmail
> > 	Mozilla
> > 	Netscape
> > 	MS Outlook
>
> Pine always worked fine when patches are imported with ^R.

It doesn't at all. It silently removes extra white space at the end of
lines. It's been a "feature" since about 4.30 or so.

Does anyone recall exactly which version this changed in? Or, have any of
the vendors reversed this wart?

	-pat

