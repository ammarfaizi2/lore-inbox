Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbTIDQ0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTIDQZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:25:40 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:31432 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265162AbTIDQX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:23:56 -0400
Date: Thu, 4 Sep 2003 12:21:00 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: "David S. Miller" <davem@redhat.com>
cc: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: /proc/net/* read drops data
In-Reply-To: <20030904004638.1d4b001d.davem@redhat.com>
Message-ID: <Pine.GSO.4.33.0309041220070.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, David S. Miller wrote:
>> D: Fixing a bug that reading /proc/net/{udp,udp6} may drop some data
>
>This fix looks good to me.  Applied.

That might fix udp, but that's not the only one to be fixed.  I'll compile
a list. (tcp for sure.)

--Ricky


