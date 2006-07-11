Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWGKKxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWGKKxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWGKKxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:53:37 -0400
Received: from khc.piap.pl ([195.187.100.11]:25035 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751001AbWGKKxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:53:36 -0400
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>
	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>
	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>
	<m3ejwt65of.fsf@defiant.localdomain> <44B248E4.2020506@pol.net>
	<m3u05p4mkx.fsf@defiant.localdomain> <44B26004.4050500@gmail.com>
	<m3r70tqxmt.fsf@defiant.localdomain> <44B2808F.8000901@pol.net>
	<m3ac7h6vxy.fsf@defiant.localdomain> <44B351CF.1090001@pol.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 11 Jul 2006 12:53:34 +0200
In-Reply-To: <44B351CF.1090001@pol.net> (Antonino A. Daplas's message of "Tue, 11 Jul 2006 15:22:55 +0800")
Message-ID: <m34pxoh0pd.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@pol.net> writes:

> X has its own i2c functionality which is completely separate from the
> kernel i2c layer.

Yes, but X11 could use I2C adapter functionality provided by the
kernel.
-- 
Krzysztof Halasa
