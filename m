Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUGTP34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUGTP34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUGTP34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 11:29:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12463 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265148AbUGTP3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 11:29:55 -0400
Date: Tue, 20 Jul 2004 11:26:40 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: List of pending v2.4 kernel bugs
Message-ID: <20040720142640.GB2348@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel fellows,

I've created a directory to store known pending v2.4 problems,
at http://master.kernel.org/~marcelo/pending-2.4-issues/ 

INDEX says:
This is the list of pending known pending v2.4 problems, each file represents
one issue.
Yes, this could be improved, but its KISS right now.

And there's currently only one entry, named "loopback-highmem", which describes
a (aha!) loopback highmem deadlock which is still unsolved.

Feel free to mail me detailed description of any other pending problems!

I hope this way we can map the pending and/or not-to-be-fixed issues 
in a central place.

Comments are welcome.
