Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313442AbSDGThX>; Sun, 7 Apr 2002 15:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313444AbSDGThW>; Sun, 7 Apr 2002 15:37:22 -0400
Received: from smtprelay7.dc2.adelphia.net ([64.8.50.39]:16832 "EHLO
	smtprelay7.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S313442AbSDGThW>; Sun, 7 Apr 2002 15:37:22 -0400
Date: Sun, 7 Apr 2002 15:44:44 -0400 (EDT)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
X-X-Sender: hirsch@atx.fast.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Levon <movement@marcelothewonderpenguin.com>,
        "Steven N. Hirsch" <shirsch@adelphia.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Two fixes for 2.4.19-pre5-ac3
In-Reply-To: <E16uIf7-0006Zw-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0204071543280.3713-100000@atx.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2002, Alan Cox wrote:

> > But what about the recent discussion on the removal of sys_call_table ?
> > 
> > (I believe it was along the lines of "it's ugly, prevent it ...", "ah,
> > but it has real uses, so why can't it stay as deprecated/unadvised ?"
> > "*no response*").
> > 
> > I'm a bit disappointed this has just gone in without any real discussion
> > on the usefulness of this for certain circumstances :(
> 
> Removing it in the -ac tree is a good way to stimulate discussion and
> fixing the code that relies on it (except for the 99% of code relying on it
> which is cracker authored trojans)

I agree.  I've forwarded the information to the openafs folks.  Given 
Derek and Derrick's respective levels of energy, it's likely already fixed 
in the CVS tree.


