Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310976AbSCHRnW>; Fri, 8 Mar 2002 12:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310978AbSCHRnN>; Fri, 8 Mar 2002 12:43:13 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:64251 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S310976AbSCHRnB>; Fri, 8 Mar 2002 12:43:01 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 8 Mar 2002 10:42:28 -0700
To: Jacky Lam <snakie@ismart.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel patches
Message-ID: <20020308174228.GD24615@turbolinux.com>
Mail-Followup-To: Jacky Lam <snakie@ismart.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <00ea01c1c6c6$083faea0$eb4a0a3d@homeuc1hfbdu7w>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ea01c1c6c6$083faea0$eb4a0a3d@homeuc1hfbdu7w>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 09, 2002  01:23 +0800, Jacky Lam wrote:
>     I want to make some statistics on all kernel patches. Could someone tell
> me how can I gather all the patches sending to Linus, Alan Cox.....?

Search mail archives for the subject [PATCH].  Note that it would be
very difficult to correlate _submitted_ patches with _accepted_ patches,
unless you had some smarts to detect that a later kernel had that patch
applied.  That is complicated by the fact that submitted and applied
patches are not always exactly the same.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

