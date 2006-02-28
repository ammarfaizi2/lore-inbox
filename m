Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWB1Ozp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWB1Ozp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWB1Ozp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:55:45 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:41665 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751037AbWB1Ozo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:55:44 -0500
Subject: Re: 2.6.16-rc5-mm1
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg Smith <gsmith@nc.rr.com>
In-Reply-To: <20060228154111.63c5d95d@gondolin.boeblingen.de.ibm.com>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	 <20060228154111.63c5d95d@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 15:55:49 +0100
Message-Id: <1141138550.4693.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 15:41 +0100, Cornelia Huck wrote:
> On Tue, 28 Feb 2006 04:24:39 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > +s390-multiple-subchannel-sets-support-fix.patch
> 
> If neither Greg nor Martin (on cc:) object, I'd prefer this patch to be
> replaced with the one in
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114102840429459&q=raw
> (it has a better check of the response code).

Fine with me.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


