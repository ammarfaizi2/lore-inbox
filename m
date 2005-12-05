Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVLEVZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVLEVZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVLEVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:25:36 -0500
Received: from mail.dvmed.net ([216.237.124.58]:60045 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932539AbVLEVZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:25:34 -0500
Message-ID: <4394B042.5050407@pobox.com>
Date: Mon, 05 Dec 2005 16:25:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>, Chris McDermott <lcm@us.ibm.com>,
       Luvella McFadden <luvella@us.ibm.com>, AJ Johnson <blujuice@us.ibm.com>,
       Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Mauelshagen@redhat.com
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E9A886@otce2k03.adaptec.com> <438F4CDA.20604@pobox.com> <4394ABE1.4040008@us.ibm.com>
In-Reply-To: <4394ABE1.4040008@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Darrick J. Wong wrote: > All, > > At last, I've been
	given the go-ahead to work on hostraid support for > dmraid. I'll post
	some patches when I've made some progress. Great! > Is linux-lvm the
	appropriate place for dmraid patches/discussion? I > couldn't find any
	mailing lists that sounded more appropriate. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> All,
> 
> At last, I've been given the go-ahead to work on hostraid support for
> dmraid.  I'll post some patches when I've made some progress.

Great!


> Is linux-lvm the appropriate place for dmraid patches/discussion?  I
> couldn't find any mailing lists that sounded more appropriate.

I think its dm-devel.  I googled for 'dm-devel' and it brought up the 
postman mailing list info.

	Jeff


