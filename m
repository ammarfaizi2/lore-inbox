Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268735AbRG0Ows>; Fri, 27 Jul 2001 10:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268784AbRG0Owi>; Fri, 27 Jul 2001 10:52:38 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:11788 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268735AbRG0Ow1>; Fri, 27 Jul 2001 10:52:27 -0400
Message-ID: <3B617FF5.3FCB46A@namesys.com>
Date: Fri, 27 Jul 2001 18:51:33 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: "Philip R. Auld" <pauld@egenera.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, kernel <linux-kernel@vger.kernel.org>,
        Chris Mason <mason@suse.com>, "Gryaznova E." <grev@namesys.botik.ru>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q7eW-0005cP-00@the-village.bc.nu> <3B6177DB.26C6D378@egenera.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Philip R. Auld" wrote:
 
> reiserfs with full data logging enabled of course does not show this behavior
> (and works really well if you are willing to take the performance hit).

Hmmm, I didn't realize this had made off our wish list and into the code.:)
We should benchmark the cost to performance.

Hans
