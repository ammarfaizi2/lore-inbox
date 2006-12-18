Return-Path: <linux-kernel-owner+w=401wt.eu-S1754507AbWLRUFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbWLRUFR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510AbWLRUFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:05:16 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:55284 "EHLO
	tirith.ics.muni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbWLRUFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:05:15 -0500
Message-ID: <4586F46B.4090500@gmail.com>
Date: Mon, 18 Dec 2006 21:04:59 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug: isicom: kobject_add failed for ttyM0 with -EEXIST
References: <20061218155714.GA21823@elte.hu> <4586C882.6090906@gmail.com> <20061218200050.GB339@elte.hu>
In-Reply-To: <20061218200050.GB339@elte.hu>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Ingo Molnar wrote:
>>> allyesconfig bzImage bootup produced 33 warning messages, of which the 
>>> first couple are attached below.
>> With which kernel? mxser had ttyM for a long time, it should be fixed 
>> in 2.6.20-rc1.
> 
> current -git.

Ok, thanks, I'll check it,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
