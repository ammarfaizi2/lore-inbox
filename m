Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132192AbQKKTkU>; Sat, 11 Nov 2000 14:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132198AbQKKTkJ>; Sat, 11 Nov 2000 14:40:09 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:49541 "EHLO
	mail.mirai.cx") by vger.kernel.org with ESMTP id <S132192AbQKKTkH>;
	Sat, 11 Nov 2000 14:40:07 -0500
Message-ID: <3A0DA037.B10D1D6A@pobox.com>
Date: Sat, 11 Nov 2000 11:38:31 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting Group
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-pre2-ac1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: "Henning P. Schmiedehausen" <hps@tanstaafl.de>,
        linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <3A0C427A.E015E58A@timpanogas.org>, <3A0C6E01.EFA10590@timpanogas.org> <8uji8q$1ru$1@forge.tanstaafl.de> <20001111111159.C9464@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:

> NT and NetWare servers don't stop forwarding
> emails when the load average gets too high -- they just work out of the
> box, and hopefully, no so will Linux (our distribution does now since
> this problem in fixed).

Don't get me started on nt - saying it "just works" is a sign of
genuine naivete - You could say nt "usually works, except for
when it's down".  Your sendmail issue with Linux was merely a
tunable parameter, while the nt problems go much deeper, and
nt often requires regular reboots in order to carry on.

> Now we know that sendmail has problems on Linux based on the this load
> average interpretation, which we would not have known if someone had
> not raised the issue.

It is good that you raised the issue -

Cheers,

jjs



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
