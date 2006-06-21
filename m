Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWFUWTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWFUWTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWFUWTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:19:10 -0400
Received: from aa003msr.fastwebnet.it ([85.18.95.66]:26329 "EHLO
	aa003msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1030340AbWFUWTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:19:09 -0400
Date: Thu, 22 Jun 2006 00:18:32 +0200
From: Mattia Dongili <malattia@linux.it>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, pavel@suse.cz,
       linux-pm@osdl.org
Subject: Re: swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060621221832.GC3798@inferi.kami.home>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, pavel@suse.cz, linux-pm@osdl.org
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621221445.GB3798@inferi.kami.home>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.17-rc4-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 12:14:45AM +0200, Mattia Dongili wrote:
[...]
> rmmod-ing sd_mod usb_storage usbhid uhci_hcd can finally suspend to disk
> and resume (s2ram).

doh, sorry. I meant "suspend to ram".

-- 
mattia
:wq!
