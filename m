Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130965AbRAaAPO>; Tue, 30 Jan 2001 19:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130971AbRAaAPE>; Tue, 30 Jan 2001 19:15:04 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:25350 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130965AbRAaAPA>; Tue, 30 Jan 2001 19:15:00 -0500
Date: Tue, 30 Jan 2001 19:14:12 -0500
From: Chris Mason <mason@suse.com>
To: "Brett G. Person" <bperson@penguincomputing.com>,
        Rik van Riel <riel@conectiva.com.br>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reiserfs problem was: Re: Version 2.4.1 cannot be built. 
Message-ID: <116120000.980900052@tiny>
In-Reply-To: <Pine.LNX.4.10.10101301538520.22416-100000@mailserver.penguincomputing.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, January 30, 2001 03:42:36 PM -0800 "Brett G. Person"
<bperson@penguincomputing.com> wrote:

> Worked fine here but  i am getting segfaults on my Reiser filesystems. 
> I've been distracted by a project over the last few days. Is what I'm
> seeing a symptom of the fs corruption people were talking about last week?
> 

If reiserfs is the cause you should have some clues in /var/log/messages.
Does the kernel compile on ext2 on the same box?

-chris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
