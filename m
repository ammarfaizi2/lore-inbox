Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTGHP5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTGHP5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:57:19 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:53662 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264235AbTGHP5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:57:19 -0400
Date: Tue, 8 Jul 2003 18:14:06 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030708161406.GJ14044@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706210243.GA25645@lea.ulyssis.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, I'm having the same problem as described in here too:
http://www.cs.helsinki.fi/linux/linux-kernel/2003-21/0619.html

Perhaps time we took another look at the AMD 74xx ide code ?
Or is this particular bug considered harmless ?

regards,

v
