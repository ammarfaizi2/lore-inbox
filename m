Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVBXMFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVBXMFc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVBXMFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:05:32 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:1680 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262267AbVBXMF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:05:26 -0500
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Erich Focht <efocht@hpce.nec.com>
In-Reply-To: <1109241901.6728.47.camel@uganda>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
	 <1109241901.6728.47.camel@uganda>
Date: Thu, 24 Feb 2005 13:05:26 +0100
Message-Id: <1109246726.16029.200.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/02/2005 13:14:21,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/02/2005 13:14:23,
	Serialize complete at 24/02/2005 13:14:23
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 13:45 +0300, Evgeniy Polyakov wrote:
> > 
> >   Todo:
> > 
> >     - Test the performance impact with lmbench
> >     - Improve the callback that turns on/off the fork connector
> >     - Create a specific module to register the callback.
> 
> Besides connector.c changes I do not have technical objections...
> But I really would like to see your second and third TODO entries in 
> ChangeLog before you will push it upstream.

Yes, I agree with that and I'm working on those two points.

Guillaume

