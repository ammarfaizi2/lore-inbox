Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132103AbRACC64>; Tue, 2 Jan 2001 21:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132099AbRACC6k>; Tue, 2 Jan 2001 21:58:40 -0500
Received: from lithium.nac.net ([64.21.52.68]:40453 "HELO lithium.nac.net")
	by vger.kernel.org with SMTP id <S130012AbRACC6a>;
	Tue, 2 Jan 2001 21:58:30 -0500
Date: Tue, 2 Jan 2001 21:28:01 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.2.19pre3's VM is great :)
Message-ID: <20010102212800.A1250@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: <tcm@nac.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I originally sent this message to Andrea Archelangi, but he felt I
should also send it here. 2.2.19pre3 is great!

Note that I'm not subscribed to the list - please replies to me and the
list if you would? Thanks :)

	You may remember me from an earlier e-mail asking where to find
the VM patch for 2.2.18 - well, I took a gander at 2.2.19pre3's fixes
due to your nudging, and boy am I happy with it. The VM - or at least
whatever controls the swapping in and out of processes - is REALLY
improved. I used to abuse the heck out of my swap whenever I'd run
mozilla, but now the swap barely takes up anything even when I'm
compiling something and using mozilla. (This is a 54MB memory available
machine with 100MB of swap) Boot speed has also increased somewhat as
well, although I've not really taken the time to figure out the
improvement in times... Just so you know, I've noticed the same style of
improvements - some INCREDIBLY noticable - on my 486 dx 50 with 16MB of
ram and 100MB of swap. It used to page out just about everything it
could to swap even when it had plenty of real memory to play with,
mainly because it seemed stupid and would cache around 4-6MB of stuff in
the ram. Now it does caching much less and actually USES the ram for
programs. (still uses 2MB or less of mem for caching, and this changes
quite a bit depending on what it's up to, but) Whee! That certaintly
makes a tremendous difference.

Felt you could use a 'this works great' story, I know if I was you I'd
want one once in a while since you proboably get more bug reports than
anything. :)

Tim

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
