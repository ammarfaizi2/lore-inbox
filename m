Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWCCSrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWCCSrp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWCCSrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:47:45 -0500
Received: from smtp-1.llnl.gov ([128.115.3.81]:45771 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S1161026AbWCCSrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:47:45 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/15] EDAC: i82875p cleanup
Date: Fri, 3 Mar 2006 10:47:01 -0800
User-Agent: KMail/1.5.3
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net, thayne@realmsys.com,
       zhenyu.z.wang@intel.com
References: <200603021748.01132.dsp@llnl.gov> <20060302183044.459ddb13.akpm@osdl.org>
In-Reply-To: <20060302183044.459ddb13.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603031047.01445.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 18:30, Andrew Morton wrote:
> Dave Peterson <dsp@llnl.gov> wrote:
> >  +#ifdef CORRECT_BIOS
> >  +fail0:
> >  +#endif
>
> What is CORRECT_BIOS?  Is the fact that it's never defined some sort of
> commentary?  ;)

I'm not sure about this.  I'm cc'ing Thayne Harbaugh and Wang Zhenyu since
their names are in the credits for the i82875p module.  Maybe they can
provide some info.
