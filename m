Return-Path: <linux-kernel-owner+w=401wt.eu-S1751407AbXAFOuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbXAFOuO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 09:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbXAFOuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 09:50:13 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:47864 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbXAFOuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 09:50:12 -0500
X-Originating-Ip: 74.109.98.100
Date: Sat, 6 Jan 2007 09:44:39 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: kernel-doc:  what is the purpose of "&struct"?
Message-ID: <Pine.LNX.4.64.0701060941240.13398@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  according to the kernel-doc HOWTO, the following should be
"highlighted" in some way if found in the extractable documentation of
your source file:

  '&struct_name' - name of a structure (up to two words including 'struct')

but examples of that, at least in the HTML, are simply printed in
regular font prefixed with '&' -- i don't see that any "highlighting"
is being done.

  the intermediate XML contains simply "&amp;struct", which certainly
doesn't suggest any special processing or highlighting.

  am i missing something?

rday
