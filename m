Return-Path: <linux-kernel-owner+w=401wt.eu-S1422946AbWLUNy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422946AbWLUNy3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422947AbWLUNy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:54:29 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:42859 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422946AbWLUNy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:54:28 -0500
Date: Thu, 21 Dec 2006 14:53:49 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated Kernel Hacker's guide to git
Message-ID: <20061221135349.GB25184@electric-eye.fr.zoreil.com>
References: <4589F9B1.2020405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4589F9B1.2020405@garzik.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> :
> I refreshed my git intro/cookbook for kernel hackers, at 
> http://linux.yyz.us/git-howto.html
> 
> This describes most of the commands I use in day-to-day kernel hacking. 
>  Let me know if there are glaring errors or missing key commands.

o 'git whatchanged shnortz' can probably be replaced with
  'git log -- schnortz' so there is one command less to remember.

o "Display changes since last git-update-index:"
  Fine but you have not told the reader what git-update-index is.

-- 
Ueimor
