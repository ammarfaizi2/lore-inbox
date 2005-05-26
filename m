Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVEZPvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVEZPvV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 11:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVEZPvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 11:51:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31421 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261576AbVEZPvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 11:51:14 -0400
Subject: Re: [Alsa-devel] Re: Oops in set_spdif_output in i810_audio
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "SuD (Alex)" <sud@latinsud.com>
In-Reply-To: <20050525214133.1aaa69f7.akpm@osdl.org>
References: <424F20F6.8010804@latinsud.com>
	 <20050525214133.1aaa69f7.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 26 May 2005 11:51:13 -0400
Message-Id: <1117122673.6261.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 21:41 -0700, Andrew Morton wrote:
> "SuD (Alex)" <sud@latinsud.com> wrote:
> >
> > Hi, i got a new ahtec laptop and i get null pointer oops everytime i 
> > load i810_audio on 2.4 and 2.6 (including 2.6.11.6) kernels.
> 
> Is this still occurring in 2.6.12-rc5?
> 

i810_audio is an OSS driver.  Removing alsa-devel from cc: and restoring
LKML.

> > 
> > Btw, Alsa snd-intel8x0 driver works, but as many distros still default 
> > to Oss i think this bug should be hunt.
> > 

Really?  Which?

Lee

