Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314597AbSD1A14>; Sat, 27 Apr 2002 20:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314650AbSD1A1z>; Sat, 27 Apr 2002 20:27:55 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:49932 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314597AbSD1A1z>;
	Sat, 27 Apr 2002 20:27:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rthrapp@sbcglobal.net (Richard Thrapp),
        linux-kernel@vger.kernel.org (linux-kernel)
Subject: Re: The tainted message 
In-Reply-To: Your message of "Sat, 27 Apr 2002 16:20:03 +0100."
             <E171TzX-0008PF-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Apr 2002 10:27:41 +1000
Message-ID: <31444.1019953661@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002 16:20:03 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>How about
>
>Warning: The module you have loaded (%s) does not seem to have an open
>	 source license. Please send any kernel problem reports to the
>	 author of this module, or duplicate them from a boot without
>	 ever loading this module before reporting them to the community
>	 or your Linux vendor

I'm going for the current message followed by "See <URL> for more
information".  <URL> defaults to http://www.tux.org/lkml/#s1-18,
vendors who want to point to their policy text can override the URL
when they build modutils.

