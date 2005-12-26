Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVLZSJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVLZSJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVLZSJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:09:29 -0500
Received: from mail.stdbev.com ([63.161.72.3]:48087 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S932076AbVLZSJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:09:28 -0500
Message-ID: <0f197de4ee389204cc946086d1a04b54@stdbev.com>
Date: Mon, 26 Dec 2005 12:09:32 -0600
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume support (try 2)
To: Lee Revell <rlrevell@joe-job.com>
Cc: <rostedt@goodmis.org>, <jaco@kroon.co.za>, <linux-kernel@vger.kernel.org>,
       <pavel@ucw.cz>, <s0348365@sms.ed.ac.uk>
Reply-to: <jason@stdbev.com>
In-Reply-To: <1135619641.8293.50.camel@mindpipe>
References: <43AF7724.8090302@kroon.co.za>
            <43AFB005.50608@kroon.co.za>
            <1135607906.5774.23.camel@localhost.localdomain>
            <200512261535.09307.s0348365@sms.ed.ac.uk>
            <1135619641.8293.50.camel@mindpipe>
X-Mailer: Hastymail 1.5-CVS
x-priority: 3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:54:00 am 26 Dec 2005 Lee Revell <rlrevell@joe-job.com> wrote:

<snip>

> >  Dare I say it, KMail has also been doing the Right Thing for a
> >  long time. It will only line wrap things that you insert by
> >  typing; pastes are left untouched.
>
> It seems that of all the popular mail clients only Thunderbird has
> this problem.  AFAICT it's impossible to make it DTRT with inline
> patches and even if it is the fact that most users get it wrong
> points to a serious usability/UI issue.
>
> Would a patch to add "Don't use Thunderbird/Mozilla Mail" to
> SubmittingPatches be accepted?  Then we can point the Mozilla
> developers at it (they have shown zero interest in fixing the problem
> so far) and hopefully this will light a fire under someone.

Maybe this is a stupid question but in terms of inline patches what exactly
would be ideal behavior from a mail client for LKML patch submitters? What
line lengths are expected to be maintained, preferred encodings, tabs vs.
spaces, etc? I have noticed that some patch submitters append an EOF after
the patch, while others do not. Would the ability to pull the patch from
the message body (assuming there was an agreed upon patch termination
string) as a separate file/download be useful? Though my client is web
based it is quite speedy and can handle large folders as well as many
desktop clients IMHO. I would gladly implement specific features to make
patch submission for LKML compliant.


\__  Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/

