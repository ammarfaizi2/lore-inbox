Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154756AbQBSSdt>; Sat, 19 Feb 2000 13:33:49 -0500
Received: by vger.rutgers.edu id <S154763AbQBSSSp>; Sat, 19 Feb 2000 13:18:45 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17462 "EHLO atrey.karlin.mff.cuni.cz") by vger.rutgers.edu with ESMTP id <S154609AbQBSSRN>; Sat, 19 Feb 2000 13:17:13 -0500
Message-ID: <20000219215555.B148@bug.ucw.cz>
Date: Sat, 19 Feb 2000 21:55:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: pa3gcu@zeelandnet.nl, gaurav.yadav@wipro.com
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Remote file system
References: <38A79CFC.D0DCD5B@wipro.com> <0002140908490B.00662@pa3gcu> <38A7DAD2.44D3645D@wipro.com> <0002141439300C.00662@pa3gcu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <0002141439300C.00662@pa3gcu>; from Richard Adams on Mon, Feb 14, 2000 at 02:33:06PM +0000
Sender: owner-linux-kernel@vger.rutgers.edu

Hi!

> >     I do not want to use telnet or some other session.
> > I want something like this
> > vi \\166.166.166.166\users\gaurav\work\linux\socket.c
> > and it opens the file.

Take a look at podfuk at
http://atrey.karlin.mff.cuni.cz/~pavel/podfuk/podfuk.html.

You can actually do vi
/#ftp:name:password@166.166.166.166/users/gaurav/work/linux/socket.c
with it.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents me at discuss@linmodems.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
