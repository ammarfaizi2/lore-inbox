Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbTHZU3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTHZU3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:29:20 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:34963 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S262708AbTHZU3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:29:19 -0400
From: Matt Gibson <gothick@codewave.demon.co.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] less /proc/net/igmp
Date: Tue, 26 Aug 2003 18:24:27 +0100
User-Agent: KMail/1.5.3
References: <20030826.150331.102449369.yoshfuji@linux-ipv6.org> <20030826.173226.114994096.yoshfuji@linux-ipv6.org> <20030827.015448.70287953.yoshfuji@linux-ipv6.org>
In-Reply-To: <20030827.015448.70287953.yoshfuji@linux-ipv6.org>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308261824.27888.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 Aug 2003 17:54, YOSHIFUJI Hideaki / 吉藤英明 wrote:
> Hello.
>
> > Okay, everyone. I'll try to fix this.
>
> Please try this patch.

Works fine for me now, against an almost-vanilla 2.6.0-test4.

Thanks,

Matt

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
