Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbUKQR3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUKQR3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbUKQR15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:27:57 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:25298 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262404AbUKQRX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:23:57 -0500
Message-ID: <419B8921.4060804@nortelnetworks.com>
Date: Wed, 17 Nov 2004 11:23:45 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] prefer TSC over PM Timer
References: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org> <1100705099.420.32.camel@localhost.localdomain>
In-Reply-To: <1100705099.420.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Is gettimeofday supposed to return the right value or be fast ?

C. All of the above.  :)

Chris
