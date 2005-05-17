Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVEQT2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVEQT2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 15:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVEQT2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 15:28:25 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:28169 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261312AbVEQT2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 15:28:18 -0400
Message-ID: <428A45C3.8060904@stud.feec.vutbr.cz>
Date: Tue, 17 May 2005 21:28:03 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Karel Kulhavy <clock@twibright.com>, Jan Spitalnik <jan@spitalnik.net>,
       linux-kernel@vger.kernel.org
Subject: Re: software mixing in alsa
References: <20050517095613.GA9947@kestrel>	 <200505171208.04052.jan@spitalnik.net>  <20050517141307.GA7759@kestrel> <1116354762.31830.12.camel@mindpipe>
In-Reply-To: <1116354762.31830.12.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
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

Lee Revell wrote:
> mpg123 is an open source application so there's no excuse for it not to
> support ALSA in 2005.

Its COPYING file says:
   This software may be distributed freely, provided that it is
   distributed in its entirety, without modifications, ...
This doesn't look like an open source license at all.
That's why Debian puts mpg123 in non-free.

Karel, you may want to try mpg321 instead. It already has ALSA support.

Michal
