Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbTAAT6s>; Wed, 1 Jan 2003 14:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTAAT6s>; Wed, 1 Jan 2003 14:58:48 -0500
Received: from [81.2.122.30] ([81.2.122.30]:27144 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261724AbTAAT6r>;
	Wed, 1 Jan 2003 14:58:47 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301012006.h01K6YAg002278@darkstar.example.net>
Subject: Re: Raw data from dedicated kernel bug database
To: lm@bitmover.com (Larry McVoy)
Date: Wed, 1 Jan 2003 20:06:34 +0000 (GMT)
Cc: mbligh@aracnet.com, hannal@us.ibm.com, eli.carter@inet.com,
       rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030101194019.GZ5607@work.bitmover.com> from "Larry McVoy" at Jan 01, 2003 11:40:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What are the chances that the raw data from the kernel bugdb could be
> made available?  I bet Bradford wants it and I know I want.
                         ^^^^^^^^

I do have a first name, you know :-).

It would be nice to have some more bugs listed in my new database - at
the moment there is only one, but I was reluctant to spend time
manually filling it, when that time could be better spent improving
the system itself.

Importing the existing data in to my database isn't going to
automatically give you all of the advantages of it, because it's
ability to search via config options, and track version information
obviously relies on that information being present, but it would be
simple enough for someone, (me, if nobody else is interested), to add
it one the database is populated.

I'm working on adding more features at the moment, but if you've got
feedback, (positive or negative), please let me hear it - traffic to
it has been pretty high, but I'm not getting much mail about it.

Personally, I think the ability to upload your .config file, and have
it say, "OK, the following bugs are known to be triggered by those
options", and to have a colour-coded table of
working/broken/untested/can't test kernel versions for each bug could
potentially save us all loads of work, but if you disagree, just let
me know.

> To calm any fears that we are trying to take over the bugdb, we're not.
> We just want to track it.  Any changes made in a BK bugdb are trivially
> exportable to an external format and if the need arises we'll work with
> IBM/OSDL to make that happen.  In fact, we can automate it.

Let me know if I can add some kind of export function to my DB that
will help BK users, Larry^WMcVoy, and I'll consider it.

John.
