Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWDXPCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWDXPCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWDXPCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:02:09 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:48321 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750839AbWDXPCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:02:08 -0400
Date: Mon, 24 Apr 2006 17:02:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: s390 patches for 2.6.17.
Message-ID: <20060424150210.GA15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
a couple of s390 patches. I sorted them in what I think is the
order of importance. 13 patches is perhaps quite a lot given
that we are already at -rc2. I sure want to see all of them
in 2.6.17, but if you want to limit the number of patches please
consider at least patches #01 - #06.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
