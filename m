Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269514AbTGOVrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269750AbTGOVrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:47:53 -0400
Received: from pat.uio.no ([129.240.130.16]:3277 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S269514AbTGOVrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:47:52 -0400
To: Julien <soda@gunnm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM : touchpad doesn't work
References: <3F146DB2.1080204@gunnm.org>
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Wed, 16 Jul 2003 00:02:29 +0200
In-Reply-To: <3F146DB2.1080204@gunnm.org> (soda@gunnm.org's message of "Tue,
 15 Jul 2003 23:10:10 +0200")
Message-ID: <wxxk7aje9e2.fsf@nommo.uio.no>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien <soda@gunnm.org> writes:

> 1 . The touchpad of my laptop doesn't work with the 2.6 Linux
> kernel, but works with the 2.5.70

  I'm guessing this is another case of Synaptic support breaking
  touchpads.  at least that's what happened to me.  Pavel Machek
  produced a patch a while ago, 

  <url: http://groups.google.com/groups?selm=6YmH.3AF.5%40gated-at.
  bofh.it&oe=UTF-8&output=gplain >

  [ ... ]

-- 
Terje
