Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290218AbSAOR61>; Tue, 15 Jan 2002 12:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290224AbSAOR6W>; Tue, 15 Jan 2002 12:58:22 -0500
Received: from borg.org ([208.218.135.231]:18695 "HELO borg.org")
	by vger.kernel.org with SMTP id <S290221AbSAOR5E>;
	Tue, 15 Jan 2002 12:57:04 -0500
Date: Tue, 15 Jan 2002 12:57:02 -0500
From: Kent Borg <kentborg@borg.org>
To: Martin Eriksson <nitrax@giron.wox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why not "attach" patches?
Message-ID: <20020115125702.B8840@borg.org>
In-Reply-To: <005901c19dec$59a89e30$0201a8c0@HOMER>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <005901c19dec$59a89e30$0201a8c0@HOMER>; from nitrax@giron.wox.org on Tue, Jan 15, 2002 at 06:44:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 06:44:58PM +0100, Martin Eriksson wrote:
> Why do many of you not _attach_ patches instead of merging them with the
> mail? It's so much cleaner and easier to have a "xxx-yyy.patch" file
> attached to the mail which can be saved in an appropriate directory. Also,
> the whitespace is always retained that way.

It is nice to have the patch to look at when looking at the mail, and
it is nice to have the mail to look at when looking at the patch.

One of the features of patch is that you can save the whole patch
e-mail to a file and use it directly; patch is willing to skip over
all the e-mail headers and regular looking text until it sees
something that looks like a patch.  Handy, huh?


-kb
