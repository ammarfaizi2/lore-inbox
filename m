Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278633AbRKFIPh>; Tue, 6 Nov 2001 03:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278642AbRKFIP2>; Tue, 6 Nov 2001 03:15:28 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:56016 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278633AbRKFIPQ>; Tue, 6 Nov 2001 03:15:16 -0500
Date: 06 Nov 2001 09:23:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8CKC8L1Hw-B@khms.westfalen.de>
In-Reply-To: <20011104210936.T14001@unthought.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.GSO.4.21.0111041453230.21449-100000@weyl.math.psu.edu> <viro@math.psu.edu> <20011104205030.P14001@unthought.net> <Pine.GSO.4.21.0111041453230.21449-100000@weyl.math.psu.edu> <20011104210936.T14001@unthought.net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jakob@unthought.net (Jakob ¥stergaard)  wrote on 04.11.01 in <20011104210936.T14001@unthought.net>:

> On Sun, Nov 04, 2001 at 03:01:12PM -0500, Alexander Viro wrote:
> >
> >
> > On Sun, 4 Nov 2001, [iso-8859-1] Jakob %stergaard wrote:
> >
> > > Strong type information (in one form or the other) is absolutely
> > > fundamental for achieving correctness in this kind of software.
> >
> > Like, say it, all shell programming?  Or the whole idea of "file as stream
> > of characters"?  Or pipes, for that matter...
> >
>
> Shell programming is great for small programs. You don't need type
> information in the language when you can fit it all in your head.
>
> Now, go write 100K lines of shell, something that does something that is not
> just shoveling lines from one app into a grep and into another app.  Let's
> say, a database.  Go implement the next Oracle replacement in bash, and tell
> me you don't care about types in your language.

And now look at how large typical /proc-using code parts are. Do they  
match better with your first or your second paragraph?

The first?

I thought so.

MfG Kai
