Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269105AbUHXXiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269105AbUHXXiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUHXXiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:38:50 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:63025 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S269114AbUHXXhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:37:02 -0400
To: Chris Leech <chris.leech@gmail.com>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>, cramerj <cramerj@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [broken?] Add MSI support to e1000
X-Message-Flag: Warning: May contain useful information
References: <C7AB9DA4D0B1F344BF2489FA165E50240619D5A0@orsmsx404.amr.corp.intel.com>
	<52u0utvka4.fsf@topspin.com>
	<41b516cb0408241449464de5a7@mail.gmail.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 24 Aug 2004 16:36:26 -0700
In-Reply-To: <41b516cb0408241449464de5a7@mail.gmail.com> (Chris Leech's
 message of "Tue, 24 Aug 2004 14:49:22 -0700")
Message-ID: <523c2cf6rp.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Aug 2004 23:36:26.0201 (UTC) FILETIME=[2C282490:01C48A33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Chris> Unfortunately, there are issues with current PRO/1000
    Chris> devices that make MSI unusable.  Other testing has show
    Chris> similar results to what you are reporting, under low load a
    Chris> few interrupts can be observed to work but the part stops
    Chris> working when stressed.  This is why MSI has not already
    Chris> been enabled in the e1000 driver.

OK, thanks for the info.  Oh well...

 - Roland
