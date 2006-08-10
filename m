Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWHJVuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWHJVuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWHJVuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:50:20 -0400
Received: from main.gmane.org ([80.91.229.2]:43938 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750784AbWHJVuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:50:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Evgeni Golov <sargentd@die-welt.net>
Subject: Re: [PATCH 06/12] hdaps: Limit hardware query rate
Date: Thu, 10 Aug 2006 23:46:49 +0200
Message-ID: <ebg9g5$kus$1@sea.gmane.org>
References: <1155203330179-git-send-email-multinymous@gmail.com>
	<11552033701218-git-send-email-multinymous@gmail.com>
	<20060810212646.GA4183@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip73.17.1411o-cud12k-03.ish.de
X-Newsreader: Sylpheed version 2.2.7 (GTK+ 2.8.18; i486-pc-linux-gnu)
Cc: hdaps-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 21:26:47 +0000 Pavel Machek <pavel@suse.cz> wrote:

> Hi!
> 
> > The polling rate is increased to 50Hz, as needed by the hdaps
> > daemon. A later patch makes this configurable.
> 
> So you have a daemon that will actually protect the harddrive? Do you
> have an url? That would be great, particulary for poor users of
> misdesigned x41 (that seem to kill disk every 6 months without this
> kind of protection...)

There is a hdapsd. Look on
http://www.thinkwiki.org/wiki/How_to_protect_the_harddisk_through_APS

regards
Evgeni

-- 
   ^^^    | Evgeni -SargentD- Golov (sargentd@die-welt.net)
 d(O_o)b  | PGP-Key-ID: 0xAC15B50C
  >-|-<   | WWW: http://www.die-welt.net   ICQ: 54116744
   / \    | IRC: #sod @ irc.german-freakz.net


