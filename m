Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285170AbRLFRBB>; Thu, 6 Dec 2001 12:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285164AbRLFRAw>; Thu, 6 Dec 2001 12:00:52 -0500
Received: from h152-148-10-6.outland.lucent.com ([152.148.10.6]:62886 "EHLO
	alpo.casc.com") by vger.kernel.org with ESMTP id <S285170AbRLFRAi>;
	Thu, 6 Dec 2001 12:00:38 -0500
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15375.41990.439405.8024@gargle.gargle.HOWL>
Date: Thu, 6 Dec 2001 11:59:50 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Rob Landley <landley@trommello.org>, "Eric S. Raymond" <esr@thyrsus.com>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <Pine.LNX.4.33L.0112061447560.1282-100000@duckman.distro.conectiva>
In-Reply-To: <20011206001558.OQCD485.femail3.sdc1.sfba.home.com@there>
	<Pine.LNX.4.33L.0112061447560.1282-100000@duckman.distro.conectiva>
X-Mailer: VM 6.95 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik> IMHO it's not acceptable that people upgrading from one 2.4
Rik> kernel to the next will have to install Python 2 on their
Rik> machine. 

So has anyone had time to test the Python version 1.5 based CML2 that
was posted?  Would that make it more acceptable?

Rik> Security bugs are and will be discovered, you cannot make it
Rik> impossible for people to do security upgrades.

This is a bogus arguement, since I could say the same about installing
new kernels.  There could (and will) be security problems with the
kernel, so we should not release new ones until we have proved they
are correct.

Yeah, I'm being a pain here, but Rik is making a bad arguement here.

Rik> Yes, I agree the method you're using to smuggle CML2 into a
Rik> stable kernel is insidious. Please stop it.

I think you're being too harsh here.  Smuggling is not happening here,
it's been very aboveboard that CML2 might (I repeat MIGHT) be
back-ported to the 2.4 series of kernels.  But since it would happen
in the -pre tree, there would be plenty of notice.  And people could
complain then.

The requirement for python2 is a bit of a pain, but hey, for 2.5, it's
not a problem.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
