Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTDYMpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263949AbTDYMpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:45:04 -0400
Received: from [65.244.37.61] ([65.244.37.61]:4421 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S263953AbTDYMpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:45:03 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A9201FD92E9@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: John Bradford <john@grabjohn.com>, jamie@shareable.org
Cc: core@enodev.com, miller@techsource.com, phillips@arcor.de,
       wli@holomorphy.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: RE: Flame Linus to a crisp!
Date: Fri, 25 Apr 2003 08:57:13 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Bradford [mailto:john@grabjohn.com]

>> > I'd like to see an x86 completely in perf board. I thought my high
>> > school digital electronics type stuff looked bad...
>> 
>> You could do it nowadays using dynamic binary translation, and an
>> absurdly simple CPU capable of accessing a large memory.  You'd need a
>> DIMM for the large memory, but get away with discrete logic for the
>> CPU if you really wanted to.
>> 
>> At perf board sizes using discrete logic, expect it run run quite slow :)
>
> Could we not take this idea to it's logical extreme, and simply
> calculate the results of every opcode, on every value, for every state
> of all of the registers, and store them in an array of DIMMs, and
> simply look up the necessary results?  I.E. a cpu which is one _huge_
> look up table :-).
>
> John.

NOW your'e talking! Alan Turing meets Julian Barbour.
