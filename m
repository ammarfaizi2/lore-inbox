Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRFDNLT>; Mon, 4 Jun 2001 09:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264241AbRFDM5Y>; Mon, 4 Jun 2001 08:57:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:10076 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264240AbRFDM5W>; Mon, 4 Jun 2001 08:57:22 -0400
Date: Mon, 4 Jun 2001 14:56:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Montgomery <william@opinicus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lowlatency 2.2.19
Message-ID: <20010604145650.C19113@athlon.random>
In-Reply-To: <Pine.LNX.3.96.1010603103738.31484A-100000@thing2.opinicus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1010603103738.31484A-100000@thing2.opinicus.com>; from william@opinicus.com on Sun, Jun 03, 2001 at 10:38:34AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2001 at 10:38:34AM -0400, William Montgomery wrote:
> Anyone have any ideas?  

Which options did you enabled? In theory the ikd patch could only make
the latency worse ;), there are no performance improvements in it but
only runtime debugging stuff.

Andrea
