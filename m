Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUHaGs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUHaGs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUHaGs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:48:28 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:3243 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S266833AbUHaGs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:48:26 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] 2.6.9-rc1-mm1: megaraid_mbox.c compile error with gcc 3.4
Date: Tue, 31 Aug 2004 02:49:00 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E57033BC9BB@exa-atlanta> <20040828130419.57a56cdd.akpm@osdl.org>
In-Reply-To: <20040828130419.57a56cdd.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408310249.00786.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Saturday 28 August 2004 16:04, Andrew Morton wrote:
> - Example Subject:
>
> 	[patch 2/5] ext2: improve scalability of bitmap searching
>
> - Note that various people's patch receiving scripts will strip away
>   Subject: text which is inside brackets [].  So you should place
>   information which has no long-term relevance to the patch inside brackets. 
>   This includes the word "patch" and any sequence numbering.  The subsystem
>   identifier ("ext2:") should hence be outside brackets.

One nit: if you do it this way then when people sort their mail by subject 
they end up with tossed subject salad, with your 2/5 sitting next to a whole 
bunch of other people's 2/5's.  So:

    [patch] ext2: improve scalability of bitmap searching [2/5]

Regards,

Daniel
