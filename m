Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282812AbRLGIMC>; Fri, 7 Dec 2001 03:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285426AbRLGILs>; Fri, 7 Dec 2001 03:11:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33037 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S282812AbRLGILm>; Fri, 7 Dec 2001 03:11:42 -0500
Date: Fri, 7 Dec 2001 09:11:37 +0100
From: Jan Kara <jack@suse.cz>
To: Michael Renner <robe@amd.co.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the vfsv0 quota?
Message-ID: <20011207091136.B22282@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0112062150160.24250-100000@trottelkunde.amd.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112062150160.24250-100000@trottelkunde.amd.co.at>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Are there any plans to incorporate the vfsv0 quota code into the 2.4
> and/or 2.5 tree? The last kernel which supported the new quota format was
> 2.4.13-ac8 afaik.
  I've written most of the code for vfsv0 quota patches to be backward
compatible (ie. both formats will be supported) so I hope I'll finish it
this weekend so submit for testing (and inclusion in 2.5). Later backport
to 2.4... If you're interested you can download patche to new quota from
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.4/quota-patch-2.4.16-1.diff.gz

								Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
