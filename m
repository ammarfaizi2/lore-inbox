Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269333AbUJQXqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269333AbUJQXqj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 19:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269335AbUJQXqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 19:46:39 -0400
Received: from ppp4-adsl-118.the.forthnet.gr ([193.92.235.118]:21051 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S269333AbUJQXqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 19:46:33 -0400
From: V13 <v13@priest.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Subject: Re: [RFC][PATCH] inotify 0.14
Date: Mon, 18 Oct 2004 02:46:25 +0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org, rml@ximian.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       bkonrath@redhat.com, greg@kroah.com
References: <1097808272.4009.0.camel@vertex>
In-Reply-To: <1097808272.4009.0.camel@vertex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410180246.27654.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 October 2004 05:44, John McCutchan wrote:
> Hello,
>
> Here is release 0.14.0 of inotify. Attached is a patch to 2.6.8.1

  AFAICS this patch adds inotify and removes dnotify. I believe that the 
addition of inotify to 2.6 series (if it is going to happen) should leave 
dnotify intact since there may be programs that rely on it (kde for example).

<<V13>>
