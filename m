Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135625AbRANWqQ>; Sun, 14 Jan 2001 17:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135700AbRANWqH>; Sun, 14 Jan 2001 17:46:07 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:33669 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S135625AbRANWp7>;
	Sun, 14 Jan 2001 17:45:59 -0500
Message-ID: <3A622C25.766F3BCE@pobox.com>
Date: Sun, 14 Jan 2001 14:45:57 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101141436010.4613-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Of course, you may be right on wuftpd. It obviously wasn't designed with
> security in mind, other alternatives may be better.

I run proftpd on all my ftp servers - it's fast, configurable
and can do all the tricks I need - even red hat seems to
agree that proftpd is the way to go.

Visit any red hat ftp site and they are running proftpd -

So, why do they keep shipping us wu-ftpd instead?

That really frosts me.

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
