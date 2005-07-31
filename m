Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263060AbVGaANJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbVGaANJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbVGaANI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:13:08 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:8884 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S263060AbVGaALm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:11:42 -0400
Date: Sat, 30 Jul 2005 20:11:39 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 -> 2.6.11 (+ata-dev patch) -- HDD is always on
Message-ID: <20050731001138.GG16285@washoe.onerussian.com>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050729041031.GU16285@washoe.onerussian.com> <42E9AFC6.9010805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E9AFC6.9010805@pobox.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 12:25:42AM -0400, Jeff Garzik wrote:
> Does this happen in unpatched 2.6.12.3 or 2.6.13-rc4?
now tested both of them -- light is constantly on in both.

does the HDD LED always signals about hardware activity or it can just
be sticky and not reset properly?

is there libata-dev patch for 2.6.8 kernel which seems to be running
fine so I might just patch it to get SATA SMART?

Thank you in advance for the feedback

-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07105
Student  Ph.D. @ CS Dept. NJIT
