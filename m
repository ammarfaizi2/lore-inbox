Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312789AbSCVSaC>; Fri, 22 Mar 2002 13:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312790AbSCVS3x>; Fri, 22 Mar 2002 13:29:53 -0500
Received: from [209.58.5.130] ([209.58.5.130]:57046 "EHLO smtp.discreet.com")
	by vger.kernel.org with ESMTP id <S312789AbSCVS3c>;
	Fri, 22 Mar 2002 13:29:32 -0500
Message-Id: <200203221829.NAA22671161@cuba.discreet.qc.ca>
Content-Type: text/plain; charset=US-ASCII
From: Martin Blais <blais@discreet.com>
Organization: Discreet Logic
To: Pavel Machek <pavel@ucw.cz>, Martin Blais <blais@IRO.UMontreal.CA>
Subject: Re: xxdiff as a visual diff tool (shameless plug)
Date: Fri, 22 Mar 2002 13:25:01 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020321061423.HIXG2746.tomts17-srv.bellnexxia.net@there> <20020322092712.GA233@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 March 2002 04:27, Pavel Machek wrote:
> Hi!
>
> It would be great to somehow split patches before feeding them to the
> patch. If you have one big hunk, and it fails because of one letter
> added somewhere in file, it is *big pain* to find/kill offending
> letter.

oops.. sorry Pavel, never mind previous email, i got it now (brain is slowly 
booting this morning).

that seems more like a patch problem/improvement request. i wouldn't do the 
patch myself... however, with the rejected hunks problem, i wonder if it is 
at all possible to avoid implementing patch functionality in the diffing tool 
itself.
