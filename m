Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264223AbUD0VRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUD0VRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbUD0VRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:17:10 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:25831 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S264223AbUD0VRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:17:08 -0400
To: Paulo Marques <pmarques@grupopie.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <408DC0E0.7090500@gmx.net> <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org>
 <1083045844.2150.105.camel@bach> <20040427092159.GC29503@lug-owl.de>
 <408E37D9.7030804@gmx.net> <408E5944.8090807@grupopie.com>
From: Junio C Hamano <junkio@cox.net>
Date: Tue, 27 Apr 2004 14:17:06 -0700
In-Reply-To: <fa.f05evul.1qmg8gd@ifi.uio.no> (Paulo Marques's message of
 "Tue, 27 Apr 2004 13:03:51 GMT")
Message-ID: <7v65blp1d9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "PM" == Paulo Marques <pmarques@grupopie.com> writes:

PM> The way I see it, they know a C string ends with a '\0'. This is like
PM> saying that a English sentence ends with a dot. If they wrote "GPL\0"
PM> they are effectively saying that the license *is* GPL period.

PM> So, where the source code? :)

I do not know if their having "GPL\0" in their object makes it
under GPL, but even if it did, I do not think they have any
obligation to give us the source.  GPL says "You may do such and
such provided if you do so and so" but that is all about the
Licensee.  It does not talk anything about what the copyright
holder may, may not, nor must do :).

