Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUKYJPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUKYJPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 04:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbUKYJPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 04:15:24 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:36623 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S263024AbUKYJOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 04:14:12 -0500
Message-ID: <41A59CBF.2030408@stud.feec.vutbr.cz>
Date: Thu, 25 Nov 2004 09:50:07 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: a.hocquel@oreka.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.28 and prism54
References: <41A509F9.5020302@oreka.com>
In-Reply-To: <41A509F9.5020302@oreka.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
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

Alexandre wrote:
> I decided to look for .config configuration for prism54, but even if I
> can find "title" in Wireless sub-menu, I can't choose it ! (with both
> "make menuconfig" and "make config")

Maybe you don't have CONFIG_EXPERIMENTAL or CONFIG_HOTPLUG enabled.

Michal

