Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWASWNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWASWNb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWASWNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:13:31 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44721 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422662AbWASWNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:13:20 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different
	approach
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
In-Reply-To: <1137696885.32195.12.camel@mindpipe>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe>  <20060119182859.GW19398@stusta.de>
	 <1137696885.32195.12.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 22:11:03 +0000
Message-Id: <1137708663.8471.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 13:54 -0500, Lee Revell wrote:
> /*
>  *      Initialisation code for Cyrix/NatSemi VSA1 softaudio
>  *
>  *      (C) Copyright 2003 Red Hat Inc <alan@redhat.com>
>  *
> 
> Why was a new OSS driver written and accepted at such a late date, when
> OSS was already deprecated?

Because
	1.	I wanted the support
	2.	It was needed for my employers systems which like everyone else were
still OSS at the time

Welcome to the *real world*

Alan
