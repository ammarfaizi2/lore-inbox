Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUGHOEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUGHOEj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 10:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUGHOEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 10:04:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20133 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262873AbUGHOED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 10:04:03 -0400
Date: Thu, 8 Jul 2004 10:03:06 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: tom st denis <tomstdenis@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Prohibited attachment type (was 0xdeadbeef)
Message-ID: <20040708140305.GT21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.53.0407070715380.17430@chaos> <20040707114836.29295.qmail@web41103.mail.yahoo.com> <20040707122916.GH21264@devserv.devel.redhat.com> <20040708055204.GF5054@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708055204.GF5054@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 07:52:04AM +0200, Pavel Machek wrote:
> > For Decimal Constant and no suffix, the table lists only:
> > int
> > long int
> > long long int
> > and thus assuming 32-bit int and 64-bit long, 3735928559 has long int type,
> > assuming 32-bit int, 32-bit long and 64-bit long long, 3735928559 has long
> > int type.
> 
> Did you mean "long long int" at the end of last sentence?

Obviously, that was a pasto.

	Jakub
