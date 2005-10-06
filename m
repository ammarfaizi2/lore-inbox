Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVJFX0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVJFX0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVJFX0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:26:38 -0400
Received: from imag.imag.fr ([129.88.30.1]:49105 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1751229AbVJFX0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:26:36 -0400
Date: Fri, 7 Oct 2005 01:26:07 +0200
From: Pierre Michon <pierre@no-spam.org>
To: linux-kernel@vger.kernel.org
Subject: Re: freebox possible GPL violation
Message-ID: <20051006232607.GA7122@linux.ensimag.fr>
Reply-To: 4345215B.7060708@cs.aau.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040722i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Fri, 07 Oct 2005 01:26:07 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Helloooo !!! Have you proofs that they have ???
Could you just reply on the simple question : why the boot is not
stateless ?

>Just stick to the FACTS and if you want to argue on
>something, bring PROOFS !
In the fact (first mail) I give :

On [1] you could see 7 steps.
Step 1 to 5 is network initialisation (adsl synchronization, dhcp,
check on the dslam, ...)
Step 6 is software update
Step 7 is operationnal

When there are no firmware update the sequence is 1, 2, 3, 4, 5, 6, 7.
When there is a firmware update it is 1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5,
6, 7.

But you haven't a freebox, so how could you have seen this that ?
Even other people agree that may be a GPL firmware stored in the freebox
(see https://linuxfr.org/~crevetor/19607.html and the author of
http://www.f-b-x.net/ told me the same thing by mail [2])

>Nonsense, you are talking about cases of softwares which were sold to
>customers with GPL code inside. This is no such case here.
Have you read the mailling ?
it was about case were hardware was lended...


>You obviously need a brain, try to get one and come back after you
>learned to use it.
You need one too, you failed to read :
"Please let's continue on legal gpl-violations.org ML."...



[1] http://forums.grenouille.com/index.php?showtopic=14659
[2]

>Tout laisse a supposer que la freebox contient bien un systeme linux
> >>minimal, elle telecharge le reste (/usr, ...) lorsqu'elle se
> >>connecte >au serveur et en cas de mise a jour du fimware le system
> >>minimal est >ecrasse et on reboot...
>
non je me suis mal exprimé, elle garde le systéme sur sa rom et le met a
jour en cas de nouvelle version, du moins c est ce que je pense. 
