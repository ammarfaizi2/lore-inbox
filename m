Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266621AbUGKQKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266621AbUGKQKo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 12:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUGKQKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 12:10:44 -0400
Received: from S010600104b97db1e.gv.shawcable.net ([24.68.211.67]:16659 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S266621AbUGKQKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 12:10:43 -0400
Date: Sun, 11 Jul 2004 09:05:04 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bk pull from bkbits screwy?
Message-ID: <20040711160504.GA1006@net-ronin.org>
References: <20040710065802.GA29604@net-ronin.org> <20040710221529.GA12455@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710221529.GA12455@hexapodia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 05:15:29PM -0500, Andy Isaacson wrote:
> How about giving the command that didn't work, and the error messages it
> printed?  I just did a pull using bk://linux.bkbits.net/linux-2.5 and it
> succeeded:

cd linux-2.5 ; bk pull

The command then told me there was nothing to pull.

While I never had a problem with the http:// URL, the bk:// URL seems to
work some days and show nothing pending on other days, even when there are
change sets that are several weeks old in bkbits that aren't in my local
repo.

-- DN
Daniel
