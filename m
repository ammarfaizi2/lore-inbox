Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270687AbTGUTkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270683AbTGUTkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:40:37 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:4015
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S270682AbTGUTkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:40:31 -0400
Message-ID: <40395.216.12.38.216.1058817334.squirrel@www.ghz.cc>
In-Reply-To: <20030721193748.GC436@elf.ucw.cz>
References: <200307210928.h6L9SUfx000613@81-2-122-30.bradfords.org.uk>
    <20030721193748.GC436@elf.ucw.cz>
Date: Mon, 21 Jul 2003 15:55:34 -0400 (EDT)
Subject: Re: 2.6.0: characters repeated when *pasting*?!
From: "Charles Lepple" <clepple@ghz.cc>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Machek said:
> Hi!
>
>> > I copied text ole.rohne@cern.ch (using gpm), pasted it to emacs (right
>> > mouse button) in another console and it came out as
>> > oooooole.rohne@cern.ch. That looks extremely weird and suggests that
>> > repeated characters are indeed software problem.
>> >
>> > Its not reproducible, and nothing interesting in logs :-(.
>>
>> Hmmm, are you sure you hadn't pressed meta-6 before pasting it in?
>
> I can't be sure... I do not think I pressed that, but it certainly is
> possible that I wanted to switch consoles and pressed that by mistake.

you can use "C-h l" (or "F1 l") next time to see emacs' idea of the last
few keystrokes. I'm guessing it was meta-6 or ctrl-u (if it was only four
'o's).

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/
