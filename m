Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWGVBtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWGVBtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 21:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWGVBtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 21:49:25 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:51330 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751084AbWGVBtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 21:49:25 -0400
Message-ID: <44C17617.5040303@namesys.com>
Date: Fri, 21 Jul 2006 18:49:27 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Benoit <ipso@snappymail.ca>
CC: David Masover <ninja@slaphack.com>, reiserfs-list@namesys.com,
       LKML <linux-kernel@vger.kernel.org>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>
Subject: Re: reiser4 status (correction)
References: <44BFFCB1.4020009@namesys.com> <44C043B5.3070501@slaphack.com>	 <44C093D2.1040703@namesys.com> <1153514509.6659.41.camel@ipso.snappymail.ca>
In-Reply-To: <1153514509.6659.41.camel@ipso.snappymail.ca>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Benoit wrote:

>
>On top of that, I don't see how a repacker would help these work loads
>much as the files usually have a high churn rate. 
>
I think Reiserfs is used on a lot more than squid servers.  For them,
80% of files don't move for long periods of time is the usual industry
statistic....
