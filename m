Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUIVK2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUIVK2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 06:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUIVK2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 06:28:05 -0400
Received: from open.hands.com ([195.224.53.39]:63128 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S263962AbUIVK2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 06:28:02 -0400
Date: Wed, 22 Sep 2004 11:39:07 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: removal of removable media - serious kernel bug (2.6.8)
Message-ID: <20040922103906.GC20688@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

according to arvan, users taking removable media out unannounced from
drives is supposed to be fixed in 2.6.

it isn't.

reports here for details, along with simple repro code:

	http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/1370.html

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

