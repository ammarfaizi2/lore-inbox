Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUE3BSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUE3BSt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 21:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUE3BSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 21:18:49 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:4763 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S261421AbUE3BSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 21:18:47 -0400
MBOX-Line: From george@galis.org  Sat May 29 21:18:46 2004
Date: Sat, 29 May 2004 21:18:46 -0400
From: George Georgalis <george@galis.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler version
Message-ID: <20040530011846.GA5975@trot.local>
References: <20040529111616.A16627@electric-eye.fr.zoreil.com> <20040529115238.A17267@electric-eye.fr.zoreil.com> <200405291330.i4TDUhsN000547@81-2-122-30.bradfords.org.uk> <20040529161247.A19214@electric-eye.fr.zoreil.com> <20040529143135.GR16099@fs.tum.de> <200405291457.i4TEvtcn000170@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405291457.i4TEvtcn000170@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.6i
Internet-Time: @96
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 03:57:55PM +0100, John Bradford wrote:
>Quote from Adrian Bunk <bunk@fs.tum.de>:
>> Whether support for gcc 2.95 should be dropped is a discussion for 2.7.
>
>Is there any single 3.x.x version of GCC that's actively in use by a large
>number of core developers?  How do we make a sensible recommendation if not?

I've used gcc-3.3.2, since about when it came out. It's been reliable
for me so I haven't noticed/tried newer versions. A few times I had
problems, with xfree or mplayer and reverted to my distro version:
gcc version 2.95.4 20011002 (Debian prerelease)

if a standard, by someone more experienced with c than myself, where
used that indicated preferred, known.works, known.broken versions of
gcc, then developers could maintain the information, for their code,
in a way that would make it easy to make global assertions on what gcc
version is preferred, works or broken. Plus, make errors that say "this
doesn't work with that gcc version" could save a lot of headaches.

// George


-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

