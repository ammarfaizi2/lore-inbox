Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbRAFHyQ>; Sat, 6 Jan 2001 02:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbRAFHyG>; Sat, 6 Jan 2001 02:54:06 -0500
Received: from frontier.axistangent.net ([63.101.14.200]:38393 "EHLO
	foozle.turbogeek.org") by vger.kernel.org with ESMTP
	id <S129655AbRAFHxq>; Sat, 6 Jan 2001 02:53:46 -0500
Date: Sat, 6 Jan 2001 07:54:02 -0600
From: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
To: Matthias Juchem <juchem@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Bug reporting script? (was: removal of redundant line in documentation)
Message-ID: <20010106075402.A3377@foozle.turbogeek.org>
In-Reply-To: <01010607054600.01947@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01010607054600.01947@gandalf>; from juchem@uni-mannheim.de on Sat, Jan 06, 2001 at 06:51:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jan 2001 06:51:58 +0000, Matthias Juchem wrote:
> Step [7.3] is redundant because it is
> already handled by the ver_linux script

If ver_linux can take off one of those steps, why not include a script
which takes care of ALL the leg work? All of the files it asks the
reporter to include are o+r...

I can whip up a bug_report script to walk the user though all of the
steps in REPORTING-BUGS, if the list isn't averse to 'dumbing down'
the process to the point where maybe some people who shouldn't be
submiting bugs (two words: 'user error') end up not being scared off
by the process.

Is perl allowed for kernel scripts intended for users, or am I stuck
with sh? 

-- 
Jeremy M. Dolan <jmd@turbogeek.org>
OpenPGP key = http://turbogeek.org/openpgp-key
OpenPGP fingerprint = 494C 7A6E 19FB 026A 1F52  E0D5 5C5D 6228 DC43 3DEE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
