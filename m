Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWALXwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWALXwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWALXwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:52:19 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:31492 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750984AbWALXwS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:52:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YrXja8k1w7yoCEBiKkNNdeihu9saMrPIcpYMHL24bydLr61EMq8difCPHe3jw3z21Jo1nLJF9SlYgrk158b5PDuEQ/efhwR9p8rBxGtGdwW1Z04N1KqgAnMadVnkRAMqtc8k/B3NLK/sSfHvlppTv9e1uOPKN1PLD5ZWkW+K8sQ=
Message-ID: <b6c5339f0601121552s7d2a034dtfe9527dd2000393@mail.gmail.com>
Date: Thu, 12 Jan 2006 18:52:17 -0500
From: Bob Copeland <email@bobcopeland.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Old hardware (was Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware)
Cc: Adrian Bunk <bunk@stusta.de>, Jon Mason <jdmason@us.ibm.com>,
       Muli Ben-Yehuda <mulix@mulix.org>, Jiri Slaby <slaby@liberouter.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1137108735.2370.110.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060112175051.GA17539@us.ibm.com>
	 <43C6ADDE.5060904@liberouter.org>
	 <20060112200735.GD5399@granada.merseine.nu>
	 <20060112214719.GE17539@us.ibm.com> <20060112220039.GX29663@stusta.de>
	 <1137105731.2370.94.camel@mindpipe> <20060112225205.GZ29663@stusta.de>
	 <1137108735.2370.110.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/06, Lee Revell <rlrevell@joe-job.com> wrote:
> I ask because the snd-nm256 driver is one that we know users have, but
> the ALSA driver has never worked (sound OK but the machine frequently
> locks up IIRC, see ALSA bug #305), and the device has been unavailable
> for years.  Basically these users are screwed if we can't get a hardware
> sample, but I think that might mean someone has to give us a whole
> laptop.

I happen to have an old laptop with an nm256, that I would gladly part
with, but it doesn't boot because of a hardware problem: it will shut
itself off between 5 and 30 seconds of turning on.  Last time I
checked it seemed to be a not-worth-fixing problem with a lot of VAIOs
of that generation.  I doubt this is worth anything to anyone but if
it is, let me know.

-Bob
