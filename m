Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbVIPI3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbVIPI3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbVIPI3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:29:09 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:52697 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161124AbVIPI3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:29:08 -0400
Subject: Re: [patch] s390: kernel stack corruption.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050915151119.GB22503@thunk.org>
References: <20050915145303.GA5959@skybase.boeblingen.de.ibm.com>
	 <20050915151119.GB22503@thunk.org>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 10:29:09 +0200
Message-Id: <1126859349.4923.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 11:11 -0400, Theodore Ts'o wrote:
> On Thu, Sep 15, 2005 at 04:53:03PM +0200, Martin Schwidefsky wrote:
> > Hi Andrew,
> > Peter discoverd another rather critical bug in entry.S.
> > This should go into 2.6.14 if possible.
> 
> This might be a good thing for the 2.6.13.x stable series.

Yes, that would be good. 

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


