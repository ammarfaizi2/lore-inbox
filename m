Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVC2HUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVC2HUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVC2HUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:20:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:28320 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262384AbVC2HCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:02:15 -0500
Date: Mon, 28 Mar 2005 23:02:01 -0800
From: Greg KH <greg@kroah.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Paul Jackson <pj@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-ID: <20050329070201.GA9983@kroah.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr> <20050328134242.4c6f7583.pj@engr.sgi.com> <1112079856.5243.24.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112079856.5243.24.camel@uganda>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 11:04:16AM +0400, Evgeniy Polyakov wrote:
> On Mon, 2005-03-28 at 13:42 -0800, Paul Jackson wrote:
> > I don't see it in my copies of *-mm or recent Linus bk trees.  Am I
> > missing something?
> 
> It was dropped from -mm tree, since bk tree where it lives 
> was in maintenance mode.
> I think connector will be appeared in the next -mm release.

Should have been in the last -mm release.  If not, please let me know.

thanks,

greg k-h
