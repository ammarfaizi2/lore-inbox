Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTKADVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 22:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTKADVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 22:21:35 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:62731
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263698AbTKADVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 22:21:35 -0500
Subject: Re: uptime reset after about 45 days
From: Robert Love <rml@tech9.net>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Jakob Oestergaard <jakob@unthought.net>,
       Maciej Zenczykowski <maze@cela.pl>, Dave Brondsema <dave@brondsema.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0310311735030.3058@gockel.physik3.uni-rostock.de>
References: <1067552357.3fa18e65d1fca@secure.solidusdesign.com>
	 <Pine.LNX.4.44.0310310005090.11473-100000@gaia.cela.pl>
	 <20031031103723.GE10792@unthought.net>
	 <Pine.LNX.4.53.0310311621010.794@gockel.physik3.uni-rostock.de>
	 <Pine.LNX.4.53.0310311735030.3058@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1067656102.1183.776.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 31 Oct 2003 22:08:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-31 at 11:40, Tim Schmielau wrote:

> ... or just apply the combined patch to save you from fixing a few rejects 
> by hand.
> 
> Robert, would you mind placing the combined patch beside the variable-HZ
> patch in your kernel.org directory, to save the cluel^W unaware?

Good idea.  I put it up along with a note:

http://www.kernel.org/pub/linux/kernel/people/rml/variable-HZ/v2.4/

	Robert Love


