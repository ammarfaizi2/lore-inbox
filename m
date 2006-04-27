Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbWD0Qte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWD0Qte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 12:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWD0Qte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 12:49:34 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:1166 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S965161AbWD0Qte
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 12:49:34 -0400
Date: Thu, 27 Apr 2006 12:49:33 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: woodys@xandros.com
Subject: Re: Highpoint SATA RAID (khe khe) status -- oopses, crashes, etc
Message-ID: <20060427164933.GF17639@washoe.onerussian.com>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
	woodys@xandros.com
References: <20060425172356.GD15201@washoe.onerussian.com> <20060426190657.GA17639@washoe.onerussian.com> <20060427053528.GB17639@washoe.onerussian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427053528.GB17639@washoe.onerussian.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Woody and everyone,

Woody's patch (without any tweaking) applied to 2.6.16.11 allowed to
load the drivers without oopsing and drives hd[eg] got visible.
As "promised" dma is unavailable feature and speeds (according to md
syncing) are quite low: 691K/sec

Thank you Woody once again

-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07105
Student  Ph.D. @ CS Dept. NJIT
