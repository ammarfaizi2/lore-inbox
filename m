Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUF3XRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUF3XRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 19:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUF3XRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 19:17:38 -0400
Received: from lum.tdiedrich.de ([193.24.211.71]:45757 "EHLO lum.tdiedrich.de")
	by vger.kernel.org with ESMTP id S261987AbUF3XRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 19:17:37 -0400
Date: Thu, 1 Jul 2004 01:17:22 +0200
From: Tobias Diedrich <ranma@tdiedrich.de>
To: linux-kernel@vger.kernel.org
Cc: Joshua <jhudson@cyberspace.org>
Subject: Re: [PATCH] restore floppy boot image
Message-ID: <20040630231721.GC29605@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@tdiedrich.de>,
	linux-kernel@vger.kernel.org, Joshua <jhudson@cyberspace.org>
References: <Pine.SUN.3.96.1040630143510.23723A-100000@grex.cyberspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SUN.3.96.1040630143510.23723A-100000@grex.cyberspace.org>
X-GPG-Fingerprint: 7168 1190 37D2 06E8 2496  2728 E6AF EC7A 9AC7 E0BC
X-GPG-Key: http://studserv.stud.uni-hannover.de/~ranma/gpg-key
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Virus: No
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.91.1
X-Spam: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua wrote:

> +	 * Previous versions copied the param table.
> +	 * We are just going to tweak it. It is in ram anyway

The DPT can be in the BIOS ROM (and probably is in a lot of cases).

-- 
Tobias						PGP: http://9ac7e0bc.2ya.com
Any sufficiently advanced bug is indistinguishable from a feature.
  -- Rich Kulawiec

