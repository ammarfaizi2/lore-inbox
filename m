Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVLPTaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVLPTaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVLPTaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:30:06 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:32949 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932381AbVLPTaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:30:05 -0500
Subject: Re: [PATCH 2/2] dasd: remove dynamic ioctl registration
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Horst.Hummel@de.ibm.com, Ric Wheeler <ric@emc.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, arnd@arndb.de,
       linux-kernel@vger.kernel.org,
       "saparnis, carol" <saparnis_carol@emc.com>
In-Reply-To: <43A2E797.9000604@emc.com>
References: <20051216143348.GB19541@lst.de>
	 <1134745099.5495.31.camel@localhost.localdomain>
	 <20051216150058.GA20144@lst.de>
	 <1134750741.5495.40.camel@localhost.localdomain>
	 <20051216163825.GA21977@lst.de>  <43A2E797.9000604@emc.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 20:30:04 +0100
Message-Id: <1134761405.5495.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 11:13 -0500, Ric Wheeler wrote:
Hi Ric,

> I am going to work with Carol (cc'ed below) to put out the module code 
> that we have under GPL.  We need to run it through our EMC (relatively 
> newish) open source process to get official permission, but I don't 
> expect any big hurdles.

That is good news.

> Are you the right person for Carol to work with on the code structure, 
> style, etc once we get the green light to move forward?

Yes, sure. We should include Horst Hummel (Horst.Hummel@de.ibm.com) to
the discussion. He takes care of the dasd driver issues in our team.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


