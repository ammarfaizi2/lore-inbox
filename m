Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWH3OEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWH3OEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 10:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWH3OEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 10:04:14 -0400
Received: from mxsf13.cluster1.charter.net ([209.225.28.213]:9860 "EHLO
	mxsf13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751061AbWH3OEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 10:04:13 -0400
X-IronPort-AV: i="4.08,189,1154923200"; 
   d="scan'208"; a="624337752:sNHT1428873714"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17653.39642.605716.215981@smtp.charter.net>
Date: Wed, 30 Aug 2006 10:04:10 -0400
From: "John Stoffel" <john@stoffel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.18-rc5 - HPT302 wierdness
In-Reply-To: <1156932104.6271.138.camel@localhost.localdomain>
References: <17652.55275.556545.19616@smtp.charter.net>
	<1156932104.6271.138.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan> Ar Maw, 2006-08-29 am 20:12 -0400, ysgrifennodd John Stoffel:
>> The drives are identical, and bought at the same time, yet on bootup
>> of 2.6.18-rc5, they show up with different values for CHS and for Max
>> Request Size.

Alan> One is using LBA48 the other is not. Looks like you have two
Alan> very different firmwares

Thanks Alan, looking at them, the firwares are quite different.  I'm
going to see about upgrading the down-rev one if possible, and I'll
check my third 120gb drive which is in an un-powered external
enclosure right now.  Whee!

Thanks,
John
