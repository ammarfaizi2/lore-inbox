Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265755AbSKFVcp>; Wed, 6 Nov 2002 16:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266149AbSKFVcp>; Wed, 6 Nov 2002 16:32:45 -0500
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:26280 "EHLO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with ESMTP
	id <S265755AbSKFVck>; Wed, 6 Nov 2002 16:32:40 -0500
To: jamesclv@us.ibm.com
Cc: Gilad Ben-ossef <gilad@benyossef.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: One for the Security Guru's
References: <20021023130251.GF25422@rdlg.net>
	<1035380716.4323.50.camel@irongate.swansea.linux.org.uk>
	<1035381547.4182.65.camel@klendathu.telaviv.sgi.com>
	<200210231514.07192.jamesclv@us.ibm.com>
Mail-Followup-To: jamesclv@us.ibm.com, Gilad Ben-ossef
 <gilad@benyossef.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Wed, 06 Nov 2002 22:39:18 +0100
In-Reply-To: <200210231514.07192.jamesclv@us.ibm.com> (James Cleverdon's
 message of "Wed, 23 Oct 2002 15:14:07 -0700")
Message-ID: <87bs529y49.fsf@Login.CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cleverdon <jamesclv@us.ibm.com> writes:

> Be surprised:  I run "gpg --verify foo.tgz.sign foo.tgz" every time I download 
> from kernel.org.  And, "rpm --checksig *.rpm" on stuff from redhat.com too.
>
> Given the recent trojaned source packages, I recommend that everyone do the 
> same.

Aren't the signatures on kernel.org automatically generated?

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          fax +49-711-685-5898
