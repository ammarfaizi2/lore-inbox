Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWGETVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWGETVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWGETVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:21:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31954 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964996AbWGETVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:21:52 -0400
Date: Wed, 5 Jul 2006 15:21:47 -0400
From: Dave Jones <davej@redhat.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Limit VIA and SIS AGP choices to x86
Message-ID: <20060705192147.GF1877@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20060705175725.GL1605@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705175725.GL1605@parisc-linux.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 11:57:25AM -0600, Matthew Wilcox wrote:
 > 
 > As far as I am aware, Alpha, PPC and IA64 don't have VIA or SIS AGP
 > chipsets available.

VIA has turned up on PPC (some Apple notebooks).
SiS I'm not sure about.

		Dave

-- 
http://www.codemonkey.org.uk
