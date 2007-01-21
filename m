Return-Path: <linux-kernel-owner+w=401wt.eu-S1751399AbXAUKkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbXAUKkx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 05:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAUKkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 05:40:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.179]:51840 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbXAUKkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 05:40:52 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
To: Tony Foiani <tkil@scrye.com>,
       Leon Woestenberg <leon.woestenberg@gmail.com>,
       linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
Reply-To: 7eggert@gmx.de
Date: Sun, 21 Jan 2007 11:40:40 +0100
References: <7FsPf-51s-9@gated-at.bofh.it> <7FxlV-3sb-1@gated-at.bofh.it> <7FyUF-5XD-21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1H8a7s-0000at-Jx@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Foiani <tkil@scrye.com> wrote:
>>>>>> "David" == David Schwartz <davids@webmaster.com> writes:

> Just last night I formatted some new "500GB" drives, and they
> eventually came back with 465GB as the displayed capacity.  Wouldn't
> it make more sense to display that as "465GiB"?

[...]

> David> Adopting IEC 60027-2 just replaces a set of well-understood
> David> problems with all new problems.
> 
> Which are clearly solved in the standards document, and remove any
> ambiguity.  Is one extra character really that painful to you?

If it's done in order to make disk vendors look good in spite of
advertizing more than they deliver, yes.

1) This change isn't nescensary - any sane person will know that it's not a
   SI unit. You wouldn't talk about megabananas == 1000000 bananas and
   expect to be taken seriously.
2) No sane person would say kibibyte as required by the standard. You'd need
   a sppech defect in order to do this, and a mental defect in order to try.
   So why should anybody adhere to the rest of this bullshit?
-- 
"Whoever said the pen is mightier than the sword obviously never
encountered automatic weapons."
-Gen. Douglas MacArthur
Friﬂ, Spammer: x39bp@lZonner.7eggert.dyndns.org .wq@ZHh.7eggert.dyndns.org
