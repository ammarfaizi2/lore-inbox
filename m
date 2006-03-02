Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWCBOxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWCBOxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 09:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWCBOxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 09:53:20 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:44809 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751123AbWCBOxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 09:53:19 -0500
Date: Thu, 2 Mar 2006 15:53:14 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: My desperation: Oops during mkfs.ext3 on large partitions
Message-ID: <20060302145314.GB25671@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <001501c63dfb$298d2780$040010ac@Tesla> <20060302134039.GB10924@favonius> <002401c63e08$32016310$040010ac@Tesla>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002401c63e08$32016310$040010ac@Tesla>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 03:47:11PM +0100, Paolo Roberti wrote:
> Maybe linux kernel should run a very quick test for RAM, it would take less 
> than a second to run and would save people a lots of troubles...

memtest86 takes so long to run because you can not test the quality of
the ram in less that a second.

  OG.
