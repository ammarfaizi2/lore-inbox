Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbTARHp6>; Sat, 18 Jan 2003 02:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbTARHp6>; Sat, 18 Jan 2003 02:45:58 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:57548 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S263256AbTARHp5>;
	Sat, 18 Jan 2003 02:45:57 -0500
Date: Sat, 18 Jan 2003 07:54:55 +0000
From: Jamie Lokier <jamie@shareable.org>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org, Richard Stallman <rms@gnu.org>
Subject: [OFFTOPIC] Is the repository of a GPL'd program itself under the GPL?
Message-ID: <20030118075455.GB18969@bjl1.asuk.net>
References: <20030118051012.GA18720@bjl1.asuk.net> <20030118072337.AAA10729@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030118072337.AAA10729@shell.webmaster.com@whenever>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 	So then suppose the tool I use for modifying the source code 
> unpacks/decrypts it, allows changes, and then packs/encrypts it 
> again. Suppose further that this tool is proprietary and not 
> available without onerous licensing requirements. Would you say 
> releasing the source code thus packed/encrypted meets the GPL?

I think that if you distribute a program in Emacs-Lisp, but you don't
provide the Emacs-Lisp interpreter, that is considered ok.  If you
distribute a program in Visual Basic under the GPL, that is considered
ok too.  Similarly if it's a GPL'd Excel spreadsheet macro, or a
program written in Jonny's own version of Prolog.

However if you distribute obfuscated or encrypted files, then clearly
that's not the preferred form for making changes.  If it's encrypted,
the preferred form obviously includes the decryption key.  (And if the
code has to be signed to run, it might include the signing key - ooh).

I don't know where the line in the sand stops.  It's not something GNU
people seem to worry much about, and neither do I as it is usually
quite clear cut one way or the other.


         -----

About BitKeeper: if it were actually essential, I think you'd have a
point.  But it isn't.

However, this begs another question: the kernel source is GPL'd.  But
is the _repository_ at bkbits.net GPL'd?  And if so, do I have the
right to demand a copy of the whole repository whenever I receive a
binary kernel, or is that right restricted to the checked out files
used to compile that kernel?

cheers,
-- Jamie

