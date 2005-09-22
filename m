Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbVIVOrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbVIVOrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVIVOru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:47:50 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:63388 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1030381AbVIVOru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:47:50 -0400
Message-ID: <4332C405.4060907@nortel.com>
Date: Thu, 22 Sep 2005 08:47:33 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Roland Dreier <rolandd@cisco.com>, dipankar@in.ibm.com,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk>
In-Reply-To: <20050922041733.GF7992@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 14:47:36.0173 (UTC) FILETIME=[925799D0:01C5BF84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

> Umm...   How many RCU callbacks are pending?

How do I check that?

Chris
