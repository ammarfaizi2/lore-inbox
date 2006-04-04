Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWDDQBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWDDQBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWDDQBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:01:05 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:52699 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750727AbWDDQBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:01:04 -0400
Subject: Re: Remove unused exports and save 98Kb of kernel size
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060403140654.GB12873@wohnheim.fh-wedel.de>
References: <1143925545.3076.35.camel@laptopd505.fenrus.org>
	 <1143926338.18439.3.camel@localhost>
	 <20060403140654.GB12873@wohnheim.fh-wedel.de>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 18:00:06 +0200
Message-Id: <1144166406.8102.1.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joern,

> > > I've made a patch to remove all EXPORT_SYMBOL's that aren't used in the
> > > kernel; it's too big for the list so it can be found at
> > > 
> > > http://www.kernelmorons.org/unexport.patch
> > 
> > no ack for net/bluetooth/ from me.
> 
> Why not?  Do you have patches pending for submission that will use
> those exported symbols?

yes, I do.

Regards

Marcel


