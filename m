Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVCBNrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVCBNrt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 08:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVCBNrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 08:47:49 -0500
Received: from [81.2.110.250] ([81.2.110.250]:1227 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262292AbVCBNrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 08:47:45 -0500
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050302080255.GA28512@redhat.com>
References: <20050228192001.GA14221@apps.cwi.nl>
	 <1109721162.15795.47.camel@localhost.localdomain>
	 <20050302075037.GH20190@apps.cwi.nl>  <20050302080255.GA28512@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109771140.20986.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 02 Mar 2005 13:45:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-02 at 08:02, Dave Jones wrote:
> If there are any of them still being used out there, I'd be even
> more surprised if they're running 2.6.  Then again, there are
> probably loonies out there running it on 386/486's. 8-)

I have one here running 2.4 still. I can test a 2.6 fix for the mtrr
init happily enough.

