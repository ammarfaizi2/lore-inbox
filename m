Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWBBSCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWBBSCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 13:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWBBSCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 13:02:06 -0500
Received: from mail.suse.de ([195.135.220.2]:14057 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751146AbWBBSCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 13:02:04 -0500
From: Andi Kleen <ak@suse.de>
To: john.blackwood@ccur.com
Subject: Re: CONFIG_K8_NUMA x86_64 no-memory node bug
Date: Thu, 2 Feb 2006 19:02:35 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com
References: <43E23692.5040807@ccur.com>
In-Reply-To: <43E23692.5040807@ccur.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602021902.35420.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2006 17:42, John Blackwood wrote:

>
> No /var/log/dmesg, boot.log, or messages file output is seen either.
> ---------------------------------------------------------------------

Boot with earlyprintk=serial,ttyS0,115200


-Andi
