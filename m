Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVKURrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVKURrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVKURrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:47:05 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:2259 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932401AbVKURrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:47:01 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Mon, 21 Nov 2005 11:46:45 -0600
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511211006.48289.rob@landley.net> <20051121172609.GA2642@elf.ucw.cz>
In-Reply-To: <20051121172609.GA2642@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511211146.46168.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 11:26, Pavel Machek wrote:
> Hi!
>
> > diff -ru linux-2.6.15-rc2.old/scripts/miniconfig.sh
> > linux-2.6.15-rc2/scripts/miniconfig.sh ---
> > linux-2.6.15-rc2.old/scripts/miniconfig.sh 2005-11-21 09:36:44.000000000
> > -0600 +++ linux-2.6.15-rc2/scripts/miniconfig.sh 2005-11-21
> > 09:21:50.000000000 -0600 @@ -0,0 +1,46 @@
>
> I see the patch is now in mainline... unfortunately
> scripts/miniconfig.sh does not seem to have execute permission.

Sorry.  I did a chmod +x here, but I dunno how to make diff -u care about 
permissions.  (I'm all ears.  Edit the -0600 by hand?)

Rob
