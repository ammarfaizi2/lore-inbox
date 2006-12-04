Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936313AbWLDMlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936313AbWLDMlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936332AbWLDMlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:41:45 -0500
Received: from [81.2.110.250] ([81.2.110.250]:148 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S936313AbWLDMlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:41:36 -0500
Date: Mon, 4 Dec 2006 12:47:43 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Kurtis D. Rader" <krader@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia nForce 4 chipsets and IDE/SATA
 drives
Message-ID: <20061204124743.240bb9ea@localhost.localdomain>
In-Reply-To: <20061204015808.GA2800@us.ibm.com>
References: <4570CF26.8070800@scientia.net>
	<20061203011737.GA2729@us.ibm.com>
	<20061204015808.GA2800@us.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The key question is whether this is a HW quirk of the nForce 4 chipset
> that the kernel can and should be working around? What tests can I run that
> will help narrow the field of investigation or provide more useful data?

Really it would need information from Nvidia on the problem, non-problem,
possible errata and/or chipset flaws. In the absence of that I don't see
a good way to debug it further than you have already.

