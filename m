Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbUAORld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 12:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUAORld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 12:41:33 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:24488 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264481AbUAORlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 12:41:32 -0500
Date: Thu, 15 Jan 2004 18:41:29 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] ABNT2 keyboards not work with >= 2.6.1 with or without -mm patchs
Message-ID: <20040115174129.GA10701@ucw.cz>
References: <200401142326.21543.murilo_pontes@yahoo.com.br> <200401151126.02722.murilo_pontes@yahoo.com.br> <20040115143252.GA1266@ucw.cz> <200401151426.28510.murilo_pontes@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401151426.28510.murilo_pontes@yahoo.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 02:26:28PM +0000, Murilo Pontes wrote:

> I patch original 2.6.1 
> Ok, your lastest patch work 100%, Thanks :)
> 
> It will be present in 2.6.2?

I hope so, yes.

> Em Qui 15 Jan 2004 14:32, Vojtech Pavlik escreveu:
> > On Thu, Jan 15, 2004 at 11:26:02AM +0000, Murilo Pontes wrote:
> > > I try 2.6.1-mm3 still not working
> > >
> > > Em Qui 15 Jan 2004 07:24, voc? escreveu:
> > > > On Wed, Jan 14, 2004 at 11:26:21PM +0000, Murilo Pontes wrote:
> > > > > BUG: ABNT2 keyboards not work with >= 2.6.1 with or without -mm
> > > > > patchs DESCRIPTION: The "/ ?" not work on console-framebuffer
> > > >
> > > > Known problem. They should work with recent -mm (if Andrew applied my
> > > > patch), and that patch should go to 2.6.2 soon. Please test if it works
> > > > correctly with latest -mm kernel.
> >
> > Yes, this patch (attached) is still not in -mm3. Hopefully it'll be in
> > -mm4.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
