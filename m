Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423106AbWJRWue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423106AbWJRWue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423132AbWJRWue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:50:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65179 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423106AbWJRWud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:50:33 -0400
Date: Wed, 18 Oct 2006 18:50:24 -0400
From: Dave Jones <davej@redhat.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org, ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Subject: Re: nobody cared about via irq
Message-ID: <20061018225024.GC4770@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org,
	ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
References: <45366556.7010907@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45366556.7010907@comcast.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 01:33:10PM -0400, John Richard Moser wrote:
 > -----BEGIN PGP SIGNED MESSAGE-----
 > Hash: SHA1
 > 
 > I'm not sure if anyone here cares either but... Ubuntu Edgy.  I think I
 > reported this problem to Ubuntu a while back, then it went away, now
 > it's back; not sure though.  CC'd them too.
 > 
 > Linux icebox 2.6.17-10-generic #2 SMP Fri Oct 6 00:36:14 UTC 2006 i686
 > GNU/Linux
 > 
 > 
 > 
 > [18142714.092000] agpgart: Found an AGP 3.0 compliant device at
 > 0000:00:00.0.
 > [18142714.092000] agpgart: Xorg tried to set rate=x12. Setting to AGP3
 > x8 mode.

This was fixed in 2.6.18

	Dave

-- 
http://www.codemonkey.org.uk
