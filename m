Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWKTMqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWKTMqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 07:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934149AbWKTMqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 07:46:12 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:13239 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S934152AbWKTMqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 07:46:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QYl1VoWVnvEOn7wyVrb9LmtBjd8IuPoPkif4dieWXH4Bpjr0eM29tydyBJF/ea/V6XsFZ9kUyLZrct+NBFMJH0/CjXD5G0jTBGUooodOLL7+jgOmTL7hSRNZB+1r57DFoKr3Ibi9W573V5saR7O1Z35eV5ahQpLRVRdQ6eQIQIM=
Message-ID: <3a5b1be00611200446m69d1c593qa13649ff6b9f0506@mail.gmail.com>
Date: Mon, 20 Nov 2006 14:46:11 +0200
From: "Komal Shah" <komal.shah802003@gmail.com>
To: "Takashi Iwai" <tiwai@suse.de>
Subject: Re: Siemens SX1: sound cleanups
Cc: "Pavel Machek" <pavel@ucw.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Vladimir Ananiev" <vovan888@gmail.com>, tony@atomide.com
In-Reply-To: <s5h4psus8n9.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061119114938.GA22514@elf.ucw.cz> <s5h4psus8n9.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 19 Nov 2006 12:49:38 +0100,
> Pavel Machek wrote:
> >
> > Hi!
> >
> > These are cleanups for codingstyle in sound parts of siemens sx1. They
> > should not change any code. Please apply,
> >
> >                                                               Pavel
>
> Which tree does include these drivers?
> I've never seen nor review it...

It's Linux Texas Instruments OMAP processors tree, hosted at following links:

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=log

OR mirror copy is also available to view at

http://www.kernel.org/git/

You have not seen those drivers, because we have _not_ yet submitted
ALSA drivers for aic23 and ts2102 to upstream.

Pavel,  better submit those -omap tree based changes to dedicated
linux-omap-open-source mailing list instead. Please visit
http://linux.omap.com Thanx.

---Komal Shah
http://komalshah.blogspot.com
