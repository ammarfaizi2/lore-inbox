Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUFWXEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUFWXEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUFWXEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:04:08 -0400
Received: from box.punkt.pl ([217.8.180.66]:12807 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S262071AbUFWXEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:04:05 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
Date: Thu, 24 Jun 2004 01:02:23 +0200
User-Agent: KMail/1.6.2
References: <200406240020.39735.mmazur@kernel.pl> <40DA0A42.3050205@nortelnetworks.com>
In-Reply-To: <40DA0A42.3050205@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200406240102.23162.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On czwartek, 24 czerwca 2004 00:54, Chris Friesen wrote:
> Not a high profile hacker, but you might try submitting a patch adding an
> include/user_abi directory (or whatever it should be called) and putting
> one of your files there, with patches to the original kernel header file to
> remove the userspace bits and include the new file.  That would maybe kick
> off some discussion.

I'm interested in guidelines, not discussion :)
Kernel guys had a couple of years since 2.4 for discussing this so something 
*must* have been agreed upon.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
