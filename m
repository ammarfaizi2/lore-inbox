Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVLQViq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVLQViq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLQVip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:38:45 -0500
Received: from lame.durables.org ([64.81.244.120]:26300 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S964951AbVLQVip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:38:45 -0500
Subject: Re: [PATCH 03/13] [RFC] ipath copy routines
From: Robert Walsh <rjwalsh@pathscale.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <84144f020512170438p5acbc445v30f275aca2d09afe@mail.gmail.com>
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com>
	 <200512161548.lRw6KI369ooIXS9o@cisco.com>
	 <84144f020512170438p5acbc445v30f275aca2d09afe@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 13:38:43 -0800
Message-Id: <1134855523.20575.29.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 14:38 +0200, Pekka Enberg wrote:
> On 12/17/05, Roland Dreier <rolandd@cisco.com> wrote:
> > +#define TRUE 1
> > +#define FALSE 0
> 
> Please kill these.

OK.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


