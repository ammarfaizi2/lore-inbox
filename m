Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291134AbSAaQa5>; Thu, 31 Jan 2002 11:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291135AbSAaQas>; Thu, 31 Jan 2002 11:30:48 -0500
Received: from ASYNC14-7.NET.CS.CMU.EDU ([128.2.188.46]:62471 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S291134AbSAaQa3>; Thu, 31 Jan 2002 11:30:29 -0500
Date: Thu, 31 Jan 2002 11:31:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Wanted: Volunteer to code a Patchbot
Message-ID: <20020131163110.GB17060@mentor.odyssey.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.0.20020131114402.02653b10@mail.amc.localnet> <Pine.LNX.4.33L.0201311150030.32634-100000@imladris.surriel.com> <20020131152920.GA2004@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131152920.GA2004@hydra>
User-Agent: Mutt/1.3.26i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 04:29:20PM +0100, Patrick Mauritz wrote:
> On Thu, Jan 31, 2002 at 11:51:53AM -0200, Rik van Riel wrote:
> > --------------------------------------------------------------
> > This is the patchbot auto-reply.
> > 
> > You tried to send me a patch (attached below) but I don't
> > know you.  To confirm that you exist (and aren't a spammer)
> > please reply to this message.
> > 
> > After receiving your reply your queued patches will be
> > published.
> > --------------------------------------------------------------
> 
> ok, so then I look for some open relay and the email address of my
> neighbour I dislike and send some hundred mails with his address in the 
> From: field - lotsa fun...

Drop anything that is not text/plain and doesn't contain

diff -urN [--exclude-from=dontdiff]
--- yyy
+++ zzz

Maybe bounce when the diff includes any files that shouldn't be part of
the diff (http://www.moses.uklinux.net/patches/dontdiff) with a nice
message to get that file and add --exclude-from=dontdiff or explain that
patches can get dropped silently when they are not in unidiff format,
include generated files, or have any type of non text/plain attachment.

And whenever spam starts 'adhering' to the suggested format of linux
kernel patches we'll get an interesting kernel indeed. Where are the
many (human) eyes in this picture anyways. Do people get to vote
for/veto patches in the patchbot queue?

Evil thought, patchbot would turn into some form of a 'slashdot' with
karma whores and petrified goats and such. Hmm, maybe we should keep
things the way they are right now.

Jan

