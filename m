Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbTGXTQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 15:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270007AbTGXTQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 15:16:54 -0400
Received: from zeke.inet.com ([199.171.211.198]:4073 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S270003AbTGXTQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 15:16:53 -0400
Message-ID: <3F20342C.5030701@inet.com>
Date: Thu, 24 Jul 2003 14:31:56 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: John Bradford <john@grabjohn.com>, diegocg@teleline.es,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ml@basmevissen.nl
Subject: Re: time for some drivers to be removed?
References: <200307241829.h6OITjR3000582@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.53.0307241422360.21139@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> p.s.  and, yes, i think "make allyesconfig" should just plain work
> for official release kernels.  so there. :-P

Why not add "make allworkingconfig"?  Turn on everything that builds; 
and maintain it so it reflects reality.  Post patches regularly. ;)

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

