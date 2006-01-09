Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWAIR30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWAIR30 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWAIR30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:29:26 -0500
Received: from [81.2.110.250] ([81.2.110.250]:57557 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030210AbWAIR3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:29:24 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Bernd Petrovitsch <bernd@firmix.at>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200601091753.36485.oliver@neukum.org>
References: <5t06S-7nB-15@gated-at.bofh.it>
	 <1136824149.5785.75.camel@tara.firmix.at>
	 <1136824880.9957.55.camel@mindpipe>  <200601091753.36485.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 17:31:40 +0000
Message-Id: <1136827900.6659.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-09 at 17:53 +0100, Oliver Neukum wrote:
> Does the Windows Explorer draw icons based only on name and metadata?

Sort of. It also plays tricks on the human by working out what icons are
visible and loading those first then filling in while the user thinks it
is ready

