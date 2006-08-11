Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWHKWLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWHKWLT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWHKWLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:11:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61661 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964786AbWHKWLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:11:18 -0400
Date: Fri, 11 Aug 2006 18:11:00 -0400
From: Dave Jones <davej@redhat.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_PM=n slim: drivers/char/agp/efficeon-agp.c
Message-ID: <20060811221100.GO26930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060811215950.GA6847@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060811215950.GA6847@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 01:59:50AM +0400, Alexey Dobriyan wrote:
 > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
 > ---
 > 
 >  drivers/char/agp/efficeon-agp.c |   16 +++++++++-------
 >  1 file changed, 9 insertions(+), 7 deletions(-)

Applied to agpgart-git, thanks.

		Dave

-- 
http://www.codemonkey.org.uk
