Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVBIPsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVBIPsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 10:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVBIPre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 10:47:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36229 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261836AbVBIPr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 10:47:29 -0500
Date: Wed, 9 Feb 2005 10:12:06 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: cliff white <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.6.10-ac12 + kernbench ==  oom-killer: (OSDL)
Message-ID: <20050209121206.GB13614@logos.cnet>
References: <20050208145707.1ebbd468@es175>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208145707.1ebbd468@es175>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 02:57:07PM -0800, cliff white wrote:
> 
> Running 2.6.10-ac10 on the STP 1-CPU machines, we don't seem to be able to complete
> a kernbench run without hitting the OOM-killer. ( kernbench is multiple kernel compiles,
> of course ) Machine is 800 mhz PIII with 1GB memory. We reduce memory for some of the runs.

Cliff, 

Please try recent v2.6.11-rc3, they include a series of OOM killer fixes from Andrea et all.

Thanks.
