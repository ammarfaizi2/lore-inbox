Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753027AbVHGWSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbVHGWSm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 18:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbVHGWSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 18:18:42 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:29447 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S1753027AbVHGWSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 18:18:41 -0400
Message-ID: <42F68896.8050604@stud.feec.vutbr.cz>
Date: Mon, 08 Aug 2005 00:17:58 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
References: <42DD67D9.60201@stud.feec.vutbr.cz> <20050804142548.5b813700.akpm@osdl.org> <20050804214044.GD1780@elf.ucw.cz>
In-Reply-To: <20050804214044.GD1780@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I assume it is in -rc6, too; it is long-standing bug and I am not
> aware of any attempts at fixing it. Please file bug report, assign to
> me.

I've filed it as Bug 5018.
Michal
