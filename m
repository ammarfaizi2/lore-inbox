Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129062AbQJ3Mdb>; Mon, 30 Oct 2000 07:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQJ3MdV>; Mon, 30 Oct 2000 07:33:21 -0500
Received: from p3E9D38F7.dip.t-dialin.net ([62.157.56.247]:24068 "EHLO
	gryffindor.sc") by vger.kernel.org with ESMTP id <S129062AbQJ3MdK>;
	Mon, 30 Oct 2000 07:33:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: /proc & xml data
In-Reply-To: <39FCDB16.B0955558@mindspring.com> <m1n1fmhl9b.fsf@frodo.biederman.org>
From: Moritz Schulte <tux@gmx.li>
Organization: Foobar
X-Mailer: Gnus v5.8.3
Date: 30 Oct 2000 13:33:00 +0100
In-Reply-To: ebiederm@xmission.com's message of "29 Oct 2000 23:54:24 -0700"
Message-ID: <87d7giecg3.fsf@gryffindor.sc>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> The general consensus is that if we have a major reorganization, in proc
> the rule will be one value per file.  And let directories do the grouping.

IIRC some time ago somebody suggested to rename 'proc' to something
like 'sys' or 'system', because it contains so many sytem information,
not only about processes; or extract all non-process-information from
proc to sys. Will this, or something like that, eventually be done
while the reorganization?

	moritz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
