Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270448AbTGXAnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 20:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271398AbTGXAnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 20:43:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:5132
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270448AbTGXAnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 20:43:52 -0400
Date: Wed, 23 Jul 2003 17:58:58 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: jimis@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related)
Message-ID: <20030724005858.GK1176@matchmail.com>
Mail-Followup-To: jimis@gmx.net, linux-kernel@vger.kernel.org
References: <3F1E6A25.5030308@gmx.net> <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu> <3F1F0995.4020300@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1F0995.4020300@gmx.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 01:17:57AM +0300, jimis@gmx.net wrote:
> What might help, and needs only be implemented on my side of the 
> connection, is requesting the packets of higher priorities first. And if I 
> know my total bandwidth, perhaps I can request as many packets needed to 
> fill it (and not flood it like it happens now).

Yes, this is exactly what wondershaper does now.

Please give it a try.

I use it on a dsl line, and it works wonders.  (pardon the pun).
