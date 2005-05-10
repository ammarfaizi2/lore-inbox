Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVEJQhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVEJQhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 12:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVEJQhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 12:37:31 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:15854 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261692AbVEJQez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 12:34:55 -0400
Message-ID: <4280E2A6.9040101@nortel.com>
Date: Tue, 10 May 2005 10:34:46 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org, Jim Nance <jlnance@sdf.lonestar.org>,
       Dave Jones <davej@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <20050507172005.GB26088@redhat.com><20050507172005.GB26088@redhat.com> <20050508012521.GA24268@SDF.LONESTAR.ORG> <427FA876.7000401@tmr.com> <427FC366.1000506@nortel.com> <4280DF80.9010409@tmr.com>
In-Reply-To: <4280DF80.9010409@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Unless you actually have such a feature, saying "let's not make what we 
> have useful because we could have something better someday" seems to be 
> a needless sacrifice of electrons.

This has already been addressed.  If we add a crappy interface now, it 
will become very difficult to remove it in the future.

Chris
