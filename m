Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263248AbUCTIgU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 03:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263251AbUCTIgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 03:36:20 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:54376 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263248AbUCTIgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 03:36:18 -0500
Date: Sat, 20 Mar 2004 09:38:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rob Roschewsk <bangzoom@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 newbie question RE: MODULES
Message-ID: <20040320083857.GB3961@mars.ravnborg.org>
Mail-Followup-To: Rob Roschewsk <bangzoom@comcast.net>,
	linux-kernel@vger.kernel.org
References: <002501c40e02$1ff8f7b0$0716a8c0@carbon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002501c40e02$1ff8f7b0$0716a8c0@carbon>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 05:32:55PM -0500, Rob Roschewsk wrote:
> 
> Version magic '2.6.4 686 gcc-3.2' should be '2.6.4 SMP preempt PENTIUM III
> gcc-3.2'

The running kernel is compiled as SMP, with preempt enabled, and for the PENTIUM III processor.
You must match this configuration to laod the modules.

	Sam
