Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWGJKt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWGJKt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWGJKt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:49:29 -0400
Received: from khc.piap.pl ([195.187.100.11]:24291 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751277AbWGJKt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:49:29 -0400
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>
	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 10 Jul 2006 12:49:26 +0200
In-Reply-To: <44B226E8.40104@pol.net> (Antonino A. Daplas's message of "Mon, 10 Jul 2006 18:07:36 +0800")
Message-ID: <m3mzbh68g9.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@pol.net> writes:

> There are better reasons (ie, smaller patch), but worse readability is not
> one of them.
>
> I could more easily grasp the code flow of cirrusfb_register() if you
> just inserted "cirrusfb_create_i2c_buses()" instead of:

Feel free to add another patch, while I don't see a need I have nothing
against :-)
-- 
Krzysztof Halasa
