Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTJ2Nsw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 08:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTJ2Nsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 08:48:52 -0500
Received: from pinguin13.kwc.at ([193.228.81.158]:57582 "EHLO
	mail.hello-penguin.com") by vger.kernel.org with ESMTP
	id S262072AbTJ2Nsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 08:48:51 -0500
Date: Wed, 29 Oct 2003 14:48:48 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI && vortex still broken in latest 2.4 and 2.6.0-test9
Message-ID: <20031029134848.GA949@hello-penguin.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.6.0-test9 (i686)
X-PGP: Key fingerprint = C090 8941 DAD8 4B09 77B1  E284 7873 9310 3BDB EA79
X-MIL: A-6172171143
User-Agent: Mutt/1.5.4i
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 3 5 9 13 27 31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I just want to note that ACPI+3c59x is still not
working on the latest kernels - the only solution
is "acpi=off".

Affected are at least
IBM Thinkpad T21  http://lkml.org/lkml/2003/6/15/111
IBM Thinkpad A21p (3c556B Laptop Hurricane)

This problem is really known for a long time and
Alan wrote on 21 Jun 2003 that it should work on -ac
trees. http://www.cs.helsinki.fi/linux/linux-kernel/2003-24/1594.html

dmesg output of my A21p (on 2.6.0-test9) can be found on
http://www.hello-penguin.com/dmesg.txt

-- 

  ciao - 
    Stefan
