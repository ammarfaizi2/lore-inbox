Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRAPT5r>; Tue, 16 Jan 2001 14:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129704AbRAPT5h>; Tue, 16 Jan 2001 14:57:37 -0500
Received: from musse.tninet.se ([195.100.94.12]:57084 "HELO musse.tninet.se")
	by vger.kernel.org with SMTP id <S130870AbRAPT5R>;
	Tue, 16 Jan 2001 14:57:17 -0500
Date: Tue, 16 Jan 2001 20:55:58 +0100
From: André Dahlqvist <anedah-9@sm.luth.se>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Does reiserfs really meet the "Linux-2.4.x patch submission policy"?
Message-ID: <20010116205558.A1171@sm.luth.se>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <937neu$p95$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <937neu$p95$1@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Jan 06, 2001 at 10:17:02AM -0800
X-Unexpected-Header: The Spanish Inquisition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

I was very surprised when I checked my local kernel.org mirror this
morning, and noticed that the latest 2.4.1 pre-patch had grown to
~180 kb in size. I was even more surprised when I realized that the
inclusion of reiserfs was the reason for this. While I am certainly
happy for the reiserfs guys, I can't help but wondering if this really
had to happen for 2.4.1.

In my understanding of your "2.4.x patch sumission guidelines" these
large patches was exactly what you wanted to avoid at this point in
time. For example, isn't reiserfs to be considered a "more involved
patch" the way you described it in this e-mail:

On Sat, Jan 06, 2001 at 10:17:02AM -0800, Linus Torvalds wrote:

> In short, releasing 2.4.0 does not open up the floor to just about
> anything.  In fact, to some degree it will probably make patches _less_
> likely to be accepted than before, at least for a while.  I want to be
> absolutely convicned that the basic 2.4.x infrastructure is solid as a
> rock before starting to accept more involved patches. 

Don't get me wrong, I am personally really excited that reiserfs was
included. I just thought that you basically wanted 2.4.1 to be "boring".

I guess it's the "pushover and wimp" showing his face again:-)
-- 

André Dahlqvist <anedah-9@sm.luth.se>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
