Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWHKWL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWHKWL3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWHKWL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:11:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964780AbWHKWL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:11:28 -0400
Date: Fri, 11 Aug 2006 18:11:12 -0400
From: Dave Jones <davej@redhat.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_PM=n slim: drivers/char/agp/intel-agp.c
Message-ID: <20060811221112.GP26930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060811220202.GB6847@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060811220202.GB6847@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 02:02:02AM +0400, Alexey Dobriyan wrote:
 > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
 > ---
 > 
 >  drivers/char/agp/intel-agp.c |    4 ++++
 >  1 file changed, 4 insertions(+)

Applied to agpgart-git, thanks

		Dave

-- 
http://www.codemonkey.org.uk
