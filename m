Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277825AbRJRRDw>; Thu, 18 Oct 2001 13:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277808AbRJRRDc>; Thu, 18 Oct 2001 13:03:32 -0400
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:45578 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S277805AbRJRRDW>;
	Thu, 18 Oct 2001 13:03:22 -0400
From: tmh@nothing-on.tv (Tony Hoyle)
Subject: Re: Input on the Non-GPL Modules
Date: Thu, 18 Oct 2001 17:08:13 GMT
Organization: cvsnt.org news server
Message-ID: <3bcf0c42.97910140@tony-home>
In-Reply-To: <Pine.LNX.4.21.0110181113020.9058-100000@wyrm.rakis.net> <20011018183217.A5055@gondor.com>
X-Trace: sisko.my.home 1003424632 29487 193.37.229.181 (18 Oct 2001 17:03:52 GMT)
X-Complaints-To: abuse@cvsnt.org
X-Newsreader: Forte Free Agent 1.21/32.243
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001 16:36:58 +0000 (UTC), Jan Niehusmann
<jan@gondor.com> wrote:


>What prevents the author of a non-GPL module who needs access to a
>GPL-only symbol from writing a small GPLed module which imports the 
>GPL-only symbol (this is allowed, because the small module is GPL), 
>and exports a basically identical symbol without the GPL-only
>restriction?
>
>Then he could use this new symbol from his non-GPL module.

This is still a GPL violation, as the small module couldn't then be
linked with the proprietary module.  Most companies aren't prepared to
get into the legally murky ground that that sort of thing entails.

Tony

