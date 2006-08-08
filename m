Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWHHWfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWHHWfM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWHHWfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:35:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:65501 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965059AbWHHWfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:35:10 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: Time to forbid non-subscribers from posting to the list?
To: Lee Revell <rlrevell@joe-job.com>, Willy Tarreau <w@1wt.eu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Alexey Zaytsev <alexey.zaytsev@gmail.com>, linux-kernel@vger.kernel.org,
       matti.aarnio@zmailer.org
Reply-To: 7eggert@gmx.de
Date: Wed, 09 Aug 2006 00:29:10 +0200
References: <6HxDe-4Ea-1@gated-at.bofh.it> <6HxWJ-52E-19@gated-at.bofh.it> <6HAKV-TE-15@gated-at.bofh.it> <6HFAX-8dl-31@gated-at.bofh.it> <6HGni-Y3-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GAa4p-0001Pa-JM@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>> On Tue, Aug 08, 2006 at 03:39:16PM +0100, Alan Cox wrote:

>> > Tag subject lines from non subscribes with [nonsub] and everyone can
>> > then decide for themselves.

> That would mean 8 fewer characters of useful information visible in the
> subject line.

I suggest introducing an X-LKML-Whitelisted: header. If you include a patch,
use a decent Subject ("[BUG]") or if you're subscribed, it's set to 'yes'.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
