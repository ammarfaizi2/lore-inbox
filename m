Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUAOR0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 12:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265191AbUAOR0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 12:26:34 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:7854 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265181AbUAOR0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 12:26:33 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [BUG] ABNT2 keyboards not work with >= 2.6.1 with or without -mm patchs
Date: Thu, 15 Jan 2004 14:26:28 +0000
User-Agent: KMail/1.5.94
References: <200401142326.21543.murilo_pontes@yahoo.com.br> <200401151126.02722.murilo_pontes@yahoo.com.br> <20040115143252.GA1266@ucw.cz>
In-Reply-To: <20040115143252.GA1266@ucw.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401151426.28510.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I patch original 2.6.1 
Ok, your lastest patch work 100%, Thanks :)

It will be present in 2.6.2?


Em Qui 15 Jan 2004 14:32, Vojtech Pavlik escreveu:
> On Thu, Jan 15, 2004 at 11:26:02AM +0000, Murilo Pontes wrote:
> > I try 2.6.1-mm3 still not working
> >
> > Em Qui 15 Jan 2004 07:24, voc? escreveu:
> > > On Wed, Jan 14, 2004 at 11:26:21PM +0000, Murilo Pontes wrote:
> > > > BUG: ABNT2 keyboards not work with >= 2.6.1 with or without -mm
> > > > patchs DESCRIPTION: The "/ ?" not work on console-framebuffer
> > >
> > > Known problem. They should work with recent -mm (if Andrew applied my
> > > patch), and that patch should go to 2.6.2 soon. Please test if it works
> > > correctly with latest -mm kernel.
>
> Yes, this patch (attached) is still not in -mm3. Hopefully it'll be in
> -mm4.
