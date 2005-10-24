Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVJXMQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVJXMQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 08:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbVJXMQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 08:16:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14031 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750949AbVJXMQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 08:16:18 -0400
Date: Mon, 24 Oct 2005 14:16:17 +0200
From: Jan Kara <jack@ucw.cz>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] GFS: quotas
Message-ID: <20051024121617.GM32605@atrey.karlin.mff.cuni.cz>
References: <20051010171048.GK22483@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010171048.GK22483@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello David!

> Code that deals with quotas.
  Is there some documentation how the GFS quotas are supposed to work?
I've just briefly looked through the code and it seems they are quite
similar to the current VFS ones. What are the differences (especially
why don't you implement GFS quotas as just another format of VFS quotas)?

							Bye
								Honza

