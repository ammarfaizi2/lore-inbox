Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270208AbTHLNQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270244AbTHLNQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:16:26 -0400
Received: from stud.tb.fh-muenchen.de ([129.187.138.35]:63403 "HELO
	stud.fh-muenchen.de") by vger.kernel.org with SMTP id S270208AbTHLNQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:16:22 -0400
Subject: Re: 2.6.0test3mm1 + gcc 3.2.3 | gcc3.3 compile error (Input/output
	error)
From: Lars Duesing <ld@stud.fh-muenchen.de>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.56.0308121603010.8716@hosting.rdsbv.ro>
References: <Pine.LNX.4.56.0308121603010.8716@hosting.rdsbv.ro>
Content-Type: text/plain
Organization: University of Applied Sciences, Students Council
Message-Id: <1060694115.22608.3.camel@ws1.intern.stud.fh-muenchen.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 12 Aug 2003 15:15:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,
> arch/i386/kernel/built-in.o: could not read symbols: Input/output error
> make: *** [.tmp_vmlinux1] Error 1
There it says :)
ld could not read data from harddisk - either it is full, or corrupted.

greetings,

 Lars

