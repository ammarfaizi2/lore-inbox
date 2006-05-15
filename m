Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWEOPuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWEOPuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWEOPuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:50:08 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:62135 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751533AbWEOPuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:50:06 -0400
Date: Mon, 15 May 2006 11:49:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Greg KH <greg@kroah.com>
cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       Fawad Lateef <fawadlateef@gmail.com>, jjoy@novell.com,
       "Nutan C." <nutanc@esntechnologies.co.in>,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, gauravd.chd@gmail.com,
       bulb@ucw.cz, Shakthi Kannan <cyborg4k@yahoo.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: GPL and NON GPL version modules
In-Reply-To: <20060515150810.GA13905@kroah.com>
Message-ID: <Pine.LNX.4.58.0605151142140.19841@gandalf.stny.rr.com>
References: <AF63F67E8D577C4390B25443CBE3B9F70928E8@esnmail.esntechnologies.co.in>
 <20060515150810.GA13905@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 May 2006, Greg KH wrote:

> On Mon, May 15, 2006 at 03:23:30PM +0530, Srinivas G. wrote:
> >
> > Will it be violating any GPL Rules?
>
> Contact a lawyer, a technical mailing list can not give legal advice.
>

Sure we can! but you'd be a fool to follow it ;)

Actually, his real question was pretty straight forward that you don't
even need to be a lawyer to answer.

He was wondering if he wrote a priority module for a priority OS and
someone else that he didn't know wrote a GPL interface to his module,
would he be responsible to release his code under the GPL.

So he's not distributing any GPL, but someone else did without his
knowledge.  This is pretty easy to answer.  He's not responsible, but the
one who wrote the GPL code and used it with his module is. He was just a
bit paranoid that someone else can cause him problems.

Issue's solved, he knows he's OK.

-- Steve

