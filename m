Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161499AbWAMIkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161499AbWAMIkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161500AbWAMIkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:40:46 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21396 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161499AbWAMIkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:40:45 -0500
Subject: Re: [patch 13/13] s390: email-address change.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: cornelia.huck@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060112170451.48438cb2.akpm@osdl.org>
References: <20060112171932.GN16629@skybase.boeblingen.de.ibm.com>
	 <20060112170451.48438cb2.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 09:40:49 +0100
Message-Id: <1137141649.6192.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 17:04 -0800, Andrew Morton wrote:
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >
> > [patch 13/13] s390: email-address change.
> 
> We can avoid churn like this by simply removing email addresses from the
> code.  You can still leave the person's name there, and people can use
> MAINTAINERS for the realname->email lookup.

But that requires that all s390 developers needs to have an entry in the
MAINTAINERS file. Not a bad idea, but it still has to be done.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


