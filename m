Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVHNMVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVHNMVg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 08:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVHNMVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 08:21:36 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:51032 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932506AbVHNMVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 08:21:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=IQ0w2FMOD8OjU2T+MG3hN9amcGJ39Pa8vrW9d5OdO3t2Dschp9vvWhxBzUK+87AjtC7LM84x+EGas+L2RZ6qDS8wfj8k83HcBddYE74jdzO/0CorP8OmUQRmGVhembsFW1mm1VpyODNNmSRfoOwsPHHDBBEY9otESQJpnfGJw5s=
Date: Sun, 14 Aug 2005 16:30:07 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Danny ter Haar <dth@picard.cistron.nl>, Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rcX really this bad ?
Message-ID: <20050814123007.GA647@mipter.zuzino.mipt.ru>
References: <ddn5aa$glm$1@news.cistron.nl> <20050814114317.GA1365@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050814114317.GA1365@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 01:43:18PM +0200, Alexander Nyberg wrote:
> On Sun, Aug 14, 2005 at 10:10:18AM +0000 Danny ter Haar wrote:
> > I've posted a couple of times than my newsserver is not stable
> > with any 2.6.13-rcX kernels.
> > Last kernel that survived is 2.6.12-mm1 (18+days)

> Is the machine running X? We need some output from it so we can debug
> what's going on, the info should be printed to the console. It would
> be great if you could run the latest kernel and see if you get any
> output. Also add nmi_watchdog=2 to the boot command line.
> 
> You can also set up a serial console or netconsole to capture the output
> from the server with the help of another machine, described in
> Documentation/serial-console.txt
> Documentation/networking/netconsole.txt

Danny, could you please go to http://bugme.osdl.org/show_bug.cgi?id=4982
and fill new info there.

Alexander, could you please forward this email to Danny if you don't get
bounces from him. I got this when tried to reply that his bug was sucked
into bugzilla.
----------------------------------------------------------------------------
Delivery to the following recipient failed permanently:

     dth@picard.cistron.nl

Technical details of permanent failure:
TEMP_FAILURE: Could not initiate SMTP conversation with any hosts:
[bitbucket.cistron.nl (100): Connection timed out]

