Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284741AbRLJXg5>; Mon, 10 Dec 2001 18:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284737AbRLJXgi>; Mon, 10 Dec 2001 18:36:38 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:19718 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284738AbRLJXgb>; Mon, 10 Dec 2001 18:36:31 -0500
Date: Mon, 10 Dec 2001 20:20:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre8
In-Reply-To: <Pine.LNX.4.40.0112101640000.10405-100000@waste.org>
Message-ID: <Pine.LNX.4.21.0112102018590.25397-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Oliver Xymoron wrote:

> On Mon, 10 Dec 2001, Marcelo Tosatti wrote:
> 
> > Here goes pre8: The next one is going to be -rc1 so please don't send me
> > any more updates and only bugfixes now.
> 
> I'd like to suggest again having patches include change logs. The basic
> idea is for a patch to contain a file like patch.foo in the top-level that
> includes the changelog entry and the maintainer runs a release script that
> build a changelog by concatenating all the patch.* files and then
> either appending them to an actual ChangeLog (preferred) or deleting
> them. This would make it much easier for people to know the details of
> what got fixed without further burdening The Maintainer.
> 
> One way to get this started would be to gather up all the existing
> change logs, add them to a ChangeLog file, and add a note about the file
> being auto-generated.

Oliver,

I know this is a much better thing to do for the changelog... However I
really want to spend my available time now on letting 2.4 in a better
state.





