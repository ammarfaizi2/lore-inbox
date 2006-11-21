Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934022AbWKUOch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934022AbWKUOch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 09:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934322AbWKUOch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 09:32:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64658 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S934022AbWKUOch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 09:32:37 -0500
Subject: Re: Where did find_bus() go in 2.6.18?
From: Arjan van de Ven <arjan@infradead.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200611211715.01963.a1426z@gawab.com>
References: <200611211715.01963.a1426z@gawab.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 21 Nov 2006 15:32:34 +0100
Message-Id: <1164119554.31358.670.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Persistent as in: get down on your knees and say "please, please, pretty 
> please"?

no as in "listen to the code review feedback and fix things and then try
again"

> 
> AFAICT, code is being ignored/rejected for the mere reason that it's not 
> considered useful; but who's to say what is useful and what's not?

no things are being reject because they're not being *used*.
Subtle but important difference ;)

But yes, you need to do a moderate amount of "selling" when submitting
code. For a driver that's easy usually, "this is a driver for device X"
and "sold" if the code is reasonable.

For major subsystem changes... you need to explain why it's worth the
disruption. If you can't explain that... then what good would it be ?

-- 
if you want to mail me at work (and no Mr Al Boldi, you really don't want to), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

