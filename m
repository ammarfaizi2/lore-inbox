Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVJSQtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVJSQtB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 12:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVJSQtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 12:49:01 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:13393 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751108AbVJSQtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 12:49:00 -0400
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: What is struct pci_driver.owner for?
X-Message-Flag: Warning: May contain useful information
References: <52sluymu26.fsf@cisco.com> <435560D0.8050205@pobox.com>
	<20051018205908.GA32435@suse.de> <52oe5mmt65.fsf@cisco.com>
	<4356695B.9050107@gmail.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 19 Oct 2005 09:48:51 -0700
In-Reply-To: <4356695B.9050107@gmail.com> (Jiri Slaby's message of "Wed, 19
 Oct 2005 17:42:19 +0200")
Message-ID: <52zmp5ihak.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 19 Oct 2005 16:48:52.0432 (UTC) FILETIME=[FC7BDD00:01C5D4CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jiri> Ok, but read Documentation/SubmittingPatches. At least
    Jiri> Signed-off-by is missing.

Thanks, but that wasn't really a patch for anyone to accept.  It was
just a note about what I just put into my git tree, which I'll ask
Linus to pull from directly when 2.6.15 opens.  Of course in the real
commit message I put a nice description and Signed-off-by: line.

 - R.
