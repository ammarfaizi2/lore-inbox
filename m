Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130095AbRBUInO>; Wed, 21 Feb 2001 03:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129845AbRBUInF>; Wed, 21 Feb 2001 03:43:05 -0500
Received: from web9608.mail.yahoo.com ([216.136.129.187]:54788 "HELO
	web9608.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129592AbRBUImz>; Wed, 21 Feb 2001 03:42:55 -0500
Message-ID: <20010221084254.89335.qmail@web9608.mail.yahoo.com>
Date: Wed, 21 Feb 2001 00:42:54 -0800 (PST)
From: <yingxian_wang@yahoo.com>
Subject: a bug in multicast IP_ADD_MEMBERSHIP
To: linux-kernel@vger.kernel.org
Cc: yingxian_wang@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a bug in multicast IP_ADD_MEMBERSHIP that
when you try to join a multicast group on a certain
interface(the wildcard or unspecified interface), it
will return with "no such device"? 

I am using redhat 6.1. 

If there is a bug, is it fixed? what is the patch
number i should apply?

Thanks
Yingxian

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices! http://auctions.yahoo.com/
