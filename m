Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbUJ1Pwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUJ1Pwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbUJ1PsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:48:25 -0400
Received: from pat.uio.no ([129.240.130.16]:55291 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261727AbUJ1Ppq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:45:46 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Seiichi Nakashima <nakasima@kumin.ne.jp>, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>
Subject: Re: linux-2.6.9 eepro100 warning
References: <200410232313.AA00003@prism.kumin.ne.jp>
	<417C9A4E.3030909@pobox.com> <wxxr7nma801.fsf@nommo.uio.no>
	<418077BC.10806@pobox.com>
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Thu, 28 Oct 2004 17:45:37 +0200
In-Reply-To: <418077BC.10806@pobox.com> (Jeff Garzik's message of "Thu, 28
 Oct 2004 00:38:20 -0400")
Message-ID: <wxxekjiq21q.fsf@nommo.uio.no>
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

> If there are e100 problems, report them to the maintainers so we can
> get them resolved ASAP...

  I got a very nice mail from Jesse Brandeburg saying pretty much the
  same thing...  so, I've pushed kernels for around 75 boxen over to
  e100 today, from eepro100.  I'm not _quite_ sure when I'll have the
  chance to boot them all, but when they do, and if they have
  problems, I'll report back.
 
> INTEL PRO/100 ETHERNET SUPPORT
> P:      John Ronciak
> M:      john.ronciak@intel.com
> P:      Ganesh Venkatesan
> M:      ganesh.venkatesan@intel.com
> P:      Scott Feldman
> M:      scott.feldman@intel.com
> W:      http://sourceforge.net/projects/e1000/
> S:      Supported
> 
> (and of course netdev@oss.sgi.com as well)

  ack.

-- 
Terje - still waiting to test hotswap SATA.   =)
