Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbUJYT5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbUJYT5g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUJYTzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:55:54 -0400
Received: from pat.uio.no ([129.240.130.16]:64679 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261227AbUJYTyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:54:49 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Seiichi Nakashima <nakasima@kumin.ne.jp>, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>
Subject: Re: linux-2.6.9 eepro100 warning
References: <200410232313.AA00003@prism.kumin.ne.jp>
	<417C9A4E.3030909@pobox.com>
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Mon, 25 Oct 2004 21:54:38 +0200
In-Reply-To: <417C9A4E.3030909@pobox.com> (Jeff Garzik's message of "Mon, 25
 Oct 2004 02:16:46 -0400")
Message-ID: <wxxr7nma801.fsf@nommo.uio.no>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

  [ ... ]

> Note that eepro100 driver will be deleted soon.

  we have several systems where e100 produces netdev watchdog errors,
  while eepro100 works without problems.  I can understand the desire
  to migrate, but what timeframe are we looking at?  roughly
  translated, when do I _have_ to start help debugging the e100
  driver?  ;-)

  I can do another attempt at rolling out the e100 driver, see what
  breaks, and try to report it around 2.6.1[01] or something like that
  if that helps?


-- 
Terje
