Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287295AbSACOQU>; Thu, 3 Jan 2002 09:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287297AbSACOQL>; Thu, 3 Jan 2002 09:16:11 -0500
Received: from ns.suse.de ([213.95.15.193]:53521 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287295AbSACOQA> convert rfc822-to-8bit;
	Thu, 3 Jan 2002 09:16:00 -0500
Date: Thu, 3 Jan 2002 15:16:00 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: =?ISO-8859-1?Q?Sebastian_Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-dj11
In-Reply-To: <20020103150922.401d0f1d.sebastian.droege@gmx.de>
Message-ID: <Pine.LNX.4.33.0201031515040.7309-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Sebastian Dröge wrote:

> sr.c:812: incompatible type for argument 1 of `invalidate_device'
> make[3]: *** [sr.o] Fehler 1
> I don't know wether this error was reported already or if it is in 2.5.2-pre6... But I'll test it ;)

pre6 breakage. untested (yet) fix already in my tree.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

