Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUIWTdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUIWTdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 15:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUIWTdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 15:33:39 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:51443 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268293AbUIWTdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 15:33:37 -0400
Message-ID: <41532504.3000005@nortelnetworks.com>
Date: Thu, 23 Sep 2004 13:33:24 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de,
       gandalf@wlug.westbo.se
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
References: <1095962839.4974.965.camel@cube>
In-Reply-To: <1095962839.4974.965.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:

> Who is doing a 32-bit userland on x86-64, and WTF for?
> Why do they not also run a 32-bit kernel?

Backwards compatibility?  Desire to run binary-only 32-bit software as well as 
64-bit software on the same kernel?

Chris
