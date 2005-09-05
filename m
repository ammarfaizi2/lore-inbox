Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVIEXVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVIEXVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 19:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVIEXVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 19:21:35 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:62338 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S964941AbVIEXVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 19:21:34 -0400
Date: Tue, 6 Sep 2005 01:21:24 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Message-ID: <20050905232124.GA32121@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
References: <20050905135546.7732ec27.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905135546.7732ec27.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
X-SA-Exim-Connect-IP: 84.189.247.218
Subject: [Bug 4962] Re: kernel status, 5 Sep 2005
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 Andrew Morton wrote:
> [Bug 4962] b2c2-flexcop module freezes
> 	http://bugzilla.kernel.org/show_bug.cgi?id=4962

"freeze" means the hardware stops generating interrupts. Reason unknown,
but a partial workaround was already merged into 2.6.13.
Please read my comments in bugzilla and close this bug.

Johannes
