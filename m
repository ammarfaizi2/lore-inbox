Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVDNWea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVDNWea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVDNWe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:34:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:16808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261603AbVDNWeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:34:24 -0400
Date: Thu, 14 Apr 2005 15:34:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: Tomasz Chmielewski <mangoo@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: poor SATA performance under 2.6.11 (with < 2.6.11 is OK)?
Message-ID: <20050414223417.GA23013@shell0.pdx.osdl.net>
References: <425E9902.8000804@interia.pl> <20050414165535.GA15440@irc.pl> <425EE9CF.4030202@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425EE9CF.4030202@interia.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tomasz Chmielewski (mangoo@interia.pl) wrote:
> or should I wait for 2.6.11.7 (?), where it should be corrected?

Wait, no longer, 2.6.11.7 has been here already ;-)  However, nothing in
this area was touched.  If there's an outstanding issue, please chase it
down, and if it's reasonable regression fix we can consider it for
the -stable tree.

thanks,
-chris
