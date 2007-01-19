Return-Path: <linux-kernel-owner+w=401wt.eu-S965012AbXASJ1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbXASJ1g (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 04:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbXASJ1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 04:27:36 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:24342 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965012AbXASJ1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 04:27:35 -0500
Subject: Re: [PATCH 1/2] Consolidate bust_spinlocks()
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Alexey Dobriyan <adobriyan@openvz.org>
Cc: akpm@osdl.org, dev@sw.ru, linux-kernel@vger.kernel.org, devel@openvz.org,
       linux-arch@vger.kernel.org
In-Reply-To: <20070118162622.GA6064@localhost.sw.ru>
References: <20070118111626.GA6040@localhost.sw.ru>
	 <1169120365.5621.4.camel@localhost> <20070118162622.GA6064@localhost.sw.ru>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 19 Jan 2007 10:27:31 +0100
Message-Id: <1169198851.31328.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 19:26 +0300, Alexey Dobriyan wrote:
> Martin, are you OK with comments tweaking in s390 code?
> -----------------------------------------
> [PATCH 1/2] Consolidate bust_spinlocks()

Yes, this should be fine now.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


