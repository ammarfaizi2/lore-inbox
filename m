Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTEKS2O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTEKS2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:28:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14810 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261842AbTEKS2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:28:13 -0400
Message-ID: <3EBE993F.1090604@pobox.com>
Date: Sun, 11 May 2003 14:41:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: davem@redhat.com, alan@lxorguk.ukuu.org.uk, haveblue@us.ibm.com,
       akpm@digeo.com, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: The magical mystical changing ethernet interface order
References: <3EB98878.5060607@us.ibm.com>	<1052395526.23259.0.camel@rth.ninka.net>	<1052405730.10038.51.camel@dhcp22.swansea.linux.org.uk>	<20030508.075438.52189319.davem@redhat.com>	<3EBA854D.1030101@pobox.com> <20030508093058.3bf3b6ba.rddunlap@osdl.org>
In-Reply-To: <20030508093058.3bf3b6ba.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> I don't care what the exact implementation is, but anything except
> depending on link (tools) order is better than now IMO.

Well, The Leader Has Spoken, even though I disagree w/ him on this :)


Short term, addressing $subject, somebody needs to look into fixing up 
2.5 net driver link order to match history.  History is probably 2.2 in 
this case, if there is a disparity between 2.2 and 2.4.

Volunteers?

	Jeff



