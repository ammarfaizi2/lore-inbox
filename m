Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVCBT6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVCBT6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVCBT6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:58:48 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:11170 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262416AbVCBT6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:58:33 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [uml-user] [PATCH] extend the limits for command line
Date: Wed, 2 Mar 2005 20:58:19 +0100
User-Agent: KMail/1.7.2
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>,
       "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>, jdike@karaya.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-user@lists.sourceforge.net
References: <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro> <200411041534.31568.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411041534.31568.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200503022058.19484.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 15:34, Blaisorblade wrote:
> On Thursday 04 November 2004 08:08, Catalin(ux aka Dino) BOIE wrote:
> > Hello!
> >
> > (I resend this because I get no feedback.)

> Sorry, miss of time.
I'm doing it now... I'll post it soon for merging. The crash fixed by Jeff 
Dike in his patch is a different things: he fixes a buffer overflow, I 
cleanup things and increase cleanly the allowed cmdline size. The original 
Catalin BOIE's patch should work in the meanwhile.

> Also, I'd like to cross-check this patch with the one used by Knoppix for
> ages to do the same thing.
Still to find.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

