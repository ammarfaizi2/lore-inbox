Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWDNWyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWDNWyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 18:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWDNWyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 18:54:04 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:61122 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751328AbWDNWyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 18:54:03 -0400
Subject: Re: [PATCH] PCMCIA: make Pretec CF Wifi use hostap_cs by default
From: Pavel Roskin <proski@gnu.org>
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Cc: linux-kernel@vger.kernel.org, Jouni Malinen <jkmaline@cc.hut.fi>
In-Reply-To: <200604092239.29008.openembedded@hrw.one.pl>
References: <200604092239.29008.openembedded@hrw.one.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Apr 2006 18:53:59 -0400
Message-Id: <1145055239.16649.58.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Marcin!

On Sun, 2006-04-09 at 22:39 +0200, Marcin Juszkiewicz wrote:
> This patch adds definition of my card to hostap_cs cardlist. It was tested on
> Sharp Zaurus C760 palmtop running 2.6.16 + pcmciautils 010 + udev 084

Thanks.  I have made a bigger patch that includes this entry already.
I'll to to submit it for Linux 2.6.17.

-- 
Regards,
Pavel Roskin

