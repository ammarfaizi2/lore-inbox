Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSHJHyP>; Sat, 10 Aug 2002 03:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSHJHyP>; Sat, 10 Aug 2002 03:54:15 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:36485 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316649AbSHJHyO> convert rfc822-to-8bit; Sat, 10 Aug 2002 03:54:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: HFS cleanup #1 - remove partition code
Date: Sat, 10 Aug 2002 10:03:14 +0200
User-Agent: KMail/1.4.1
Cc: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
References: <200208092347.g79NlFF96768@saturn.cs.uml.edu>
In-Reply-To: <200208092347.g79NlFF96768@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208101003.14158.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 10. August 2002 01:47 schrieb Albert D. Cahalan:
> Oliver Neukum writes:
> > this removes the independent partition code from hfs.
> > This is the first patch taking an axe to hfs so it'll be in shape for
> > 2.6. Does anybody object to it being sent to Linus ?
>
> I really hate to say it, but... yes. This is needed
> for CD-ROMs.

Oh shit. So it's either this, or pushing that into
the CD layer. Are there plans to do that?
Sessions properly done need it anyway.

So for the time being I retract it.

	Regards
		Oliver

