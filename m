Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUAGMfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 07:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUAGMfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 07:35:33 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:21889 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S266206AbUAGMfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 07:35:32 -0500
X-Sender-Authentication: net64
Date: Wed, 7 Jan 2004 13:35:08 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: andreas@xss.co.at, andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: ACPI: problem on ASUS PR-DLS533
Message-Id: <20040107133508.6798d1b9.skraw@ithnet.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C88@PDSMSX403.ccr.corp.intel.com>
References: <3ACA40606221794F80A5670F0AF15F8401720C88@PDSMSX403.ccr.corp.intel.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004 18:50:03 +0800
"Yu, Luming" <luming.yu@intel.com> wrote:

> >I have some TRL-DLS here (P-III). They have dual AIC onboard which are
> not
> >recognised under 2.4.24 but work flawlessly with ACPI in 2.4.23.
> 
> Are you sure?  You seems to want to say this is a regression.

Yes. That is exactly what happened.

2.4.23 works flawlessly
2.4.24 does not recognise both onboard aic

Regards,
Stephan
