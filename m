Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWCNPVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWCNPVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWCNPVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:21:25 -0500
Received: from box.punkt.pl ([217.8.180.66]:30866 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S1751329AbWCNPVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:21:24 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: llh-announce@lists.pld-linux.org
Subject: [ANNOUNCE] linux-libc-headers dead
Date: Tue, 14 Mar 2006 16:19:36 +0100
User-Agent: KMail/1.9.1
Cc: VMiklos <vmiklos@frugalware.org>, "Dan Kegel" <dank@kegel.com>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141619.36609.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LLH hasn't seen a new release for a lot more than six months now and up until 
today I hoped to get back on track with new releases. But I've just spent 
some time doing a 2.6.14 update, and it came back to me, that I'd have to 
spend up to 10 hours just to get a basic 2.6.14.0 ready. And there'd still be 
2.6.15 waiting, 2.6.16 just around the corner plus sorting through all the 
bug reports that came in during those months and all the internal rearranging 
I either had planned or that's being forced by new kernel releases (eg. 
addition of asm-powerpc).

I stopped having both the time and the will for such commitments a couple of 
months ago.

Should anyone want to take over, I'd be happy to give hints, pointers, and 
whatnot. Just don't get overexcited -- diffs between new kernel versions get 
bigger, not smaller, and after a couple of years there's still no long term 
solution in sight.

Oh, and women don't fall for the "I hack kernel stuff" line. I was lied to.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
