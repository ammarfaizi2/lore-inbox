Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264895AbUFVReF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbUFVReF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUFVReE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:34:04 -0400
Received: from [213.146.154.40] ([213.146.154.40]:26249 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264895AbUFVRcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:32:16 -0400
Date: Tue, 22 Jun 2004 18:32:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040622173215.GA6300@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, Petr Vandrovec <VANDROVE@vc.cvut.cz>
References: <A095D7F069C@vcnet.vc.cvut.cz> <20040622151236.GE20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622151236.GE20632@lug-owl.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 05:12:36PM +0200, Jan-Benedict Glaw wrote:
> Just merge the vmware modules upstream. Then, such breakage will be
> detected early and probably fixed without putting a lot of work into it
> (from your point of view).

a) vmware modules themselves aren't under a free license
b) even if they were there's not really much interest in modules that can't
   work with non-free userspace

