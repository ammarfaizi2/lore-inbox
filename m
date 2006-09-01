Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWIAVQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWIAVQv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWIAVQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:16:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8395 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750897AbWIAVQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:16:50 -0400
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: Ian Stirling <ian.stirling@mauve.plus.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Rob Landley <rob@landley.net>,
       linux-kernel@vger.kernel.org, linux-tiny@selenic.com, devel@laptop.org
In-Reply-To: <44F88B98.3020805@mauve.plus.com>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433068.3012.115.camel@pmac.infradead.org>
	 <200608251611.50616.rob@landley.net>
	 <1156538115.3038.6.camel@pmac.infradead.org>
	 <44F2CB09.2010809@aitel.hist.no>
	 <1156764076.5340.75.camel@pmac.infradead.org>
	 <44F88B98.3020805@mauve.plus.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 14:15:28 -0700
Message-Id: <1157145328.2473.3.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 20:35 +0100, Ian Stirling wrote:
> I thought that it used rather a lot more RAM. I still often(ish)
> compile a kernel on my PII/300/128M. It'd be moderately annoying if it
> got slower, and there was no way to turn it off.

There will definitely be a way to turn it off. Compilers with all the
relevant bugs fixed are not common yet -- in fact I think I may have the
_only_ existing builds with all the patches collected together.

-- 
dwmw2


-- 
VGER BF report: H 0
