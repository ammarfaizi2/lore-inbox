Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbULDTVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbULDTVY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 14:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbULDTVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 14:21:24 -0500
Received: from main.gmane.org ([80.91.229.2]:29059 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262573AbULDTVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 14:21:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <aripollak@gmail.com>
Subject: Re: Linux 2.6.10-rc3
Date: Sat, 04 Dec 2004 14:21:10 -0500
Message-ID: <cot2mv$2di$1@sea.gmane.org>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>	<pan.2004.12.04.09.06.09.707940@nn7.de>	<87oeha6lj1.fsf@sycorax.lbl.gov> <cosrt1$j67$1@sea.gmane.org> <87eki66jx8.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
In-Reply-To: <87eki66jx8.fsf@sycorax.lbl.gov>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at ALSA driver CVS a couple of days ago to see if anything has 
changed since the last release (included in 2.6.10-rc1+). The only thing 
significant that I found in the CVS intel8x0 driver, which added 
pci_disable_device() calls, didn't seem to help the resume problem when 
I applied this change to my kernel sources.

Alex Romosan wrote:
> i saw there were some changes to alsa cvs having to do with the new
> pci device handling. i'll reconfigure the kernel with alsa as modules
> and try alsa cvs to see if that makes any difference. thanks.
> 
> --alex--
> 

