Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310191AbSCKQ1v>; Mon, 11 Mar 2002 11:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310196AbSCKQ1o>; Mon, 11 Mar 2002 11:27:44 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:21987 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S310192AbSCKQ1b>; Mon, 11 Mar 2002 11:27:31 -0500
Message-Id: <200203111540.IAA11492@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Hans Reiser <reiser@namesys.com>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Date: Mon, 11 Mar 2002 09:25:14 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0203110508080.17717-100000@mhw.ULib.IUPUI.Edu> <200203111444.HAA11416@tstac.esa.lanl.gov> <3C8CD687.5000608@namesys.com>
In-Reply-To: <3C8CD687.5000608@namesys.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 March 2002 09:08 am, Hans Reiser wrote:
> Steven Cole wrote:
> >Quoting from "VMS General User's Manual", section 2.1.1 Filenames, Types,
> >and Versions, "You can control the number of versions of a file by
> > specifying the /VERSION_LIMIT qualifier to the DCL commands
> > CREATE/DIRECTORY, SET DIRECTORY, and SET FILE."
> >
> >It has been a while (about 12 years), but IIRC, you could set
> > /VERSION_LIMIT=1 and effectively get rid of the annoying versions.  But
> > some people, the Aunt Tillie types, were always tripping over their
> > shoelaces and unintentially deleting files. For those people, the version
> > feature probably seemed a blessing rather than a curse.
> >
> >Steven
>
> So with every command to create a directory you had to add an extra
> parameter specifying that you didn't want extra versions or else you got
> them?
>
> Hans

That is not my recollection.  What I remember is that our system admistrator
set up people's accounts so that the default behaviour was as desired by
the individual.  This has gotten me curious, so I went out to a storage container
and dug out an old VAX 4000/60 which hasn't run since about 1992.  If it works,
I'll be able to answer with more than vague memories.  At least for VMS 5.1, which
is just a bit out of date as the current version is 7.3 or so.  Now, if can just 
remember the SYSTEM password. ;-)

Perhaps others whose VMS experience is more recent than mine can answer this question.
More generally, if the infrastructure for keeping file versions around is going
to be generated for other reasons, having the option to have file versions could
be useful for some people.  I certainly remember people who loved that feature,
but I wasn't one of them.

Steven
