Return-Path: <linux-kernel-owner+w=401wt.eu-S933208AbWLaUJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208AbWLaUJI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 15:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933209AbWLaUJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 15:09:08 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:24853 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933208AbWLaUJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 15:09:07 -0500
Date: Sun, 31 Dec 2006 22:09:03 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line macros.
Message-ID: <20061231200903.GF3730@rhun.ibm.com>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain> <20061231194501.GE3730@rhun.ibm.com> <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 02:49:48PM -0500, Robert P. J. Day wrote:

> there would appear to be *lots* of cases where the ({ }) notation is
> used when nothing is being returned.  i'm not sure you can be that
> adamant about that distinction at this point.

IMHO, the main point of CodingStyle is to clarify how new code should
be written and old code should've been written.

Cheers,
Muli
