Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbTFEWm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbTFEWm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:42:56 -0400
Received: from freeside.toyota.com ([63.87.74.7]:25515 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S265234AbTFEWm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:42:56 -0400
Message-ID: <3EDFCA99.7040709@tmsusa.com>
Date: Thu, 05 Jun 2003 15:56:25 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Edward Tandi <ed@efix.biz>
Subject: Re: 2.5.70 latest: breaks gnome
References: <20030604142241.0dc6f34e.shemminger@osdl.org>	 <3EDE7398.70005@tmsusa.com>	<20030605111212.33e63d46.shemminger@osdl.org>	 <3EDFB3E2.2090308@tmsusa.com> <20030605143346.197a8923.akpm@digeo.com>	 <3EDFBD08.5060902@tmsusa.com> <1054852458.1886.18.camel@wires.home.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Tandi wrote:

>8) from dmesg: process `named' is using obsolete setsockopt SO_BSDCOMPAT
>  
>

If you remove SO_BSDCOMPAT from the include
files and recompile named (just rebuild the srpm)
that will go away -

Best Regards,

Joe

