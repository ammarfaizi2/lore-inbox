Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTEQV5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 17:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTEQV5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 17:57:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43447 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261873AbTEQV5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 17:57:31 -0400
Date: Sat, 17 May 2003 15:09:33 -0700 (PDT)
Message-Id: <20030517.150933.74723581.davem@redhat.com>
To: fw@deneb.enyo.de
Cc: sim@netnation.org, linux-kernel@vger.kernel.org
Subject: Re: Route cache performance under stress
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <87d6iit4g7.fsf@deneb.enyo.de>
References: <20030516222436.GA6620@netnation.com>
	<1053138910.7308.3.camel@rth.ninka.net>
	<87d6iit4g7.fsf@deneb.enyo.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Florian Weimer <fw@deneb.enyo.de>
   Date: Sat, 17 May 2003 09:31:04 +0200
   
   The hash collision problem appears to be resolved, but not the more
   general performance issues.  Or are there any kernels without a
   routing cache?

I think your criticism of the routing cache is not well
founded.
