Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWAIQcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWAIQcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWAIQcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:32:23 -0500
Received: from [81.2.110.250] ([81.2.110.250]:19596 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750955AbWAIQcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:32:23 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Yaroslav Rastrigin <yarick@it-territory.ru>,
       Kasper Sandberg <lkml@metanurb.dk>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1136823313.9957.37.camel@mindpipe>
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	 <200601091403.46304.yarick@it-territory.ru>
	 <1136813783.8412.4.camel@localhost>
	 <200601091656.48355.yarick@it-territory.ru>
	 <1136822827.6659.25.camel@localhost.localdomain>
	 <1136823313.9957.37.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 16:34:33 +0000
Message-Id: <1136824473.6659.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-09 at 11:15 -0500, Lee Revell wrote:
> Would you care to elaborate on this statement?  It's not clear to me how
> perception could differ from reality in this case.  If it seems faster
> doesn't that mean it is faster?

Depends who is measuring and what is being measured. 

If you want to understand how to make the kernel faster you care about
real speed changes. Application authors may well want to look at
perceptual tricks (like splash screens, opening windows early before you
have the code even loaded to do much else etc)

Alan

