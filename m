Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUIHNiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUIHNiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUIHNeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:34:18 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:3080 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267661AbUIHNbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:31:48 -0400
Date: Wed, 8 Sep 2004 14:31:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908143143.A32002@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908125755.GC3106@holomorphy.com> <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com>; from zwane@linuxpower.ca on Wed, Sep 08, 2004 at 09:34:03AM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 09:34:03AM -0400, Zwane Mwaikambo wrote:
> Hmm, whenever i've brought up weak functions in a patch it's never well 
> received. Frankly i prefer it to littering the architectures with similar 
> functions.

That's what we have asm-generic for.
