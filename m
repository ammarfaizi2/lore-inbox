Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUJWMlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUJWMlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 08:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbUJWMlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 08:41:08 -0400
Received: from science.horizon.com ([192.35.100.1]:31038 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261156AbUJWMkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 08:40:55 -0400
Date: 23 Oct 2004 12:40:54 -0000
Message-ID: <20041023124054.580.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: SCO's copyright claims or lack thereof (was: Re: Linux v2.6.9 and GPL Buyout)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for everyone's information... this is a bit long, but ends up arguing
that, if Caldera/SCO had a shred of evidence of copyright infringeent,
they would heva introduced it in court by now.

Briefly, IBM asked the judge to rule that they weren't infringing any of
Calsera/SCO's copyrights by distributing Linux.  And they further asked
for that ruling immediately, before the trial is complete.  In such
a pre-trial summary judgement motion, the rules are heavily biased in
favor of Caldera/SCO; they only have to show a tiny bit of evidence to
defeat the motion.

But if they don't, IBM wins that part of their case immediately.
Do not pass go, do not collect $200.  Judgement issued, Case closed.

The final opportunity to present any such evidence of infringement was
September 15.  Even if there is any, they've had their chance to bring it
up, and now the judge is going to rule as if it doesn't exist.

Given that that last "put up or shut up" deadline has passed without
any serious evidence of infringment, it looks a hell of a lot like there
simply isn't any.


Okay, the story in detail... sorry if this is long, but I'm trying
to cover everything.  If this doesn't bore you, see the links for
the actual documents.  Then you can go and read the exhibits.


In response to Caldera/SCO's claims, IBM filed some counter-claims.
One of them (the tenth) is a claim for for a declaratory judgement
that they are not infringing Caldera/SCO's copyrights by their Linux
activities, which include copying and modification.

IBM's Second Amended Counter-Claims against Caldera/SCO:
http://sco.tuxrocks.com/Docs/IBM/IBM-127.pdf
http://www.groklaw.net/article.php?story=20040331043539340

For those who don't know, in the U.S. civil courts, the parties have
to bring all the claims and counter-claims that "go together" (usually
meaning involving the same poeple, the same acts, and at the same
time) to the court in one lawsuit.  Such claims and counter-claims are
"compulsory", meaning that if you don't raise them now, you aren't allowed
a second chance.  This is part of the principe that, if you don't like
the results of the lawsuit, you aren't allowed to sue again over the same
thing.  (There is an exception, of course, for "new evidence" that you can
show is significant and was unavailable at the time of the first lawsuit.)

So counter-claims aren't (just) a legal tactic, but are also required if
you have any points to raise about the squabble.  In this case, Caldera/SCO
has claimed copyright infringement, so IBM has asked for the opposite
ruling, a finding that they do not infringe.


A suit for declaratory judgement is a way for the defendant to ask a judge
to rule on an issue which they have hanging over their heads.  If you have
a realistic apprehension of being sued over an issue, but the would-be
plaintiff is milking the issue for FUD rather than taking it to court,
you can sue for a declaratory judgement that you're *not* doing something
or other.  You have to prove that your fears are realistic, however, in
addition to the issue you want a judgement on.


Anyway, a few months after the above, IBM made a motion for partial
summary judgement on it's tenth counterclaim, the declaratory judgement.
Summary judgement is asking for an early ruling when the opposition
hasn't got a snowball's chance in hell.  (And partial summary judgement
is asking for summary judgement on part of your claims.  In this case,
the tenth counterclaim.)

Motions for summary judgement are easy to oppose - you only have to
demonstrate a tiny bit of evidence for your side, as the judge is
required to give you the benefit of any possible doubt - but you have
to show that there's *something* which could let you win the case.
Or show that you can expect some evidence to show up in the course of
discovery and the trial.

But such motions are also potentially very dangerous, becuase they're very
one-sided.  If granted, the moving party has won that part of the case.
Game over.  If denied, the moving party hasn't lost anything, and gets
to try again later, in the formal trial.

For more on summary judgements from an actual (retired) lawyer, see
http://www.groklaw.net/article.php?story=20040922030300643

For a declaratory judgement of copyright non-infringement, it's a bit
trickier, because the onus is on the defendant to show infringement.
IBM just has to ask for the judgement, and if Caldera/SCO doesn't show
that there *is* infringement, the judge is required to give them their
declaration.  (This is because proving a negative like non-infringement
is basically impossible.)  The same onus applies in summary judgement,
but the standards are lower.  Caldera/SCO just has to show that they
have a ghost of a chance of showing infringement.


As with all things in courts, the process for resolving a motion is
very formalized.  First, there's the motion itself, usually just a 
page long:
http://sco.tuxrocks.com/Docs/IBM/IBM-152.pdf
http://www.groklaw.net/article.php?story=20040521100818411

Along with that, the moving party files a memorandum in support, making their
case for why the judge should grant the motion:
http://sco.tuxrocks.com/Docs/IBM/IBM-153.pdf
http://www.groklaw.net/article.php?story=20040521183116140
This should contain every issue the moving party intends to raise;
there's no second chance.  It may also have documents, declarations,
affidavits, or whatever attached as evidence of the points being made.

Then the other party gets to submit a memorandum in opposition, explaining
why the motion should be denied:
http://sco.tuxrocks.com/Docs/IBM/IBM-206.pdf
http://www.groklaw.net/article.php?story=20040709151719495
This needs to oppose any claim made in the original memorandum in
support that you want to dispute.  If you fail to dispute it, it's taken
as consent.

And then the moving party gets a final reply memorandum, which is limited to
rebutting any new points raised in the memorandum in opposition:
http://sco.tuxrocks.com/Docs/IBM/IBM-256.pdf
http://www.groklaw.net/article.php?story=20040827214309785

This particular motion launched a few sub-motions, namely Caldera/SCO's
Rule 56(f) Motion in Further Opposition [195], IBM's motion to strike
some of the declarations atached to SCO's opposition [246], etc.  All of
which have associated support, opposition and reply memornada as well.
There are also length limits on the various memoranda, and you'll see a
bunch of Ex Parte motions (meaning requests to be the judge directly,
that the other side doesn't get to oppose) for permission to file
overlength memoranda.


But, anyway, after the motion, memorandum in support, memorandum
in opposition, and reply memorandum in support, come oral arguments.
On this motion, and all the associated sub-motions, oral arguments took
place on September 15:
http://sco.tuxrocks.com/Docs/IBM/IBM-302.pdf
http://www.groklaw.net/article.php?story=20040923031043578

After that, the only thing left is for the judge to rule.  This can
happen immediately ("from the bench") if the judge thinks it's simple
enough, or the judge can "take it under advisement" and think about it
some more and issue a written ruling later.  The latter is standard in
more important and complex issues like this one.

We're still waiting for the judge (Dale A. Kimball) to issue a ruling,
but as far as the parties are concerned, the issue is over.  They've said
everything they're going to say.  It's all on the table.  We're waiting
for the fat lady to sing, but all the other actors have left the stage.


And you can look in vain through all of the court filings and the
transcript of the oral hearing for a shred of plausible evidence of
copyright infringement in Linux.  Caldera/SCO spend the entire time
arguing that they need more discovery to find anything.

If they had one stinking line of code they could plausibly claim was
copied, that could torpedo IBM's counterclaim.  One line is probably
too trivial to constitute infringement by itself, but Caldera/SCO could
handwave about the tip of an iceberg.

And they don't need ironclad proof.  They just have to show that they
have a *chance* of proving it when it comes time for the full trial.
The judge is required to look at things "in the light most favorable to
the nonmoving party" when considering motions for summary judgement.


So given that:
- Caldera/SCO could lose their whole copyright claim, now and forever,
  over this motion, and
- A very very small amount of actual evidence would utterly defeat the
  motion

it was pretty much their last chance to *begin* introducing evidence
of copyright infringement.  "Now would be a good time, Scotty."

Except that September 15 would heva been a good time.  *Now* it's
too late.

If you further consider that no such evidence WAS introduced (all
the links are above, to the PDF scans and text transcripts, if you
want to look for yourself), the obvious conclusion is that they
haven't GOT any.

It's not like there's any point to holding it in reserve for later.
If IBM wins the declaratory judgement, Caldera/SCO is enjoined from
bothering them about infringment even if there is any!
The final "speak now, or forever hold your peace" moment for this issue
was September 15.


Now, if the judge denies the motion (which could happen for any number
of reasons, some highly technical), then both sides get to address the
counterclaim again at the trial.  IBM doesn't lose, they just fail to
win early.  But it sure doesn't look to me like SCO had any issues they
raised that were so open-and-shut it would make sense to risk losing such
a major thing over any possible benefit to be gained by keeping it secret.

But, you say, this is assuming that SCO is rational.  What if they're
completely nutty and don't follow that logic?  Well, then, they have
an excellent chance of losing the issue, having the motion granted,
and being enjoined from bothering IBM about it any more.

This isn't strictly binding on parties *other* than IBM, but it sure
gives SCO an awfully steep uphill battle to fight.
