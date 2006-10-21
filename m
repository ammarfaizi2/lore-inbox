Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWJUU4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWJUU4D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 16:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWJUU4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 16:56:01 -0400
Received: from pm-mx5.mgn.net ([195.46.220.209]:30961 "EHLO pm-mx5.mgn.net")
	by vger.kernel.org with ESMTP id S1161032AbWJUU4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 16:56:00 -0400
Date: Sat, 21 Oct 2006 22:55:57 +0200
From: Damien Wyart <damien.wyart@free.fr>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       NetDev <netdev@vger.kernel.org>
Subject: Re: [PATCH] e100_shutdown: netif_poll_disable hang
Message-ID: <20061021205557.GA2836@localhost.localdomain>
References: <20061020182820.978932000@mvista.com> <453936E0.1010204@intel.com> <45393B0B.8090301@intel.com> <87slhh1s90.fsf@brouette.noos.fr> <453A5EBA.5050701@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453A5EBA.5050701@intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Auke Kok <auke-jan.h.kok@intel.com> [2006-10-21 10:54]: his change
> breaks something else (a reboot with netconsole, possibly suspend).
> Please give the latest version I sent a try. Daniel confirmed me that
> it works, but it's always nice to hear it from more people.

Yes, your version works here too.

-- 
Damien Wyart
