Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270489AbTGNBkp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 21:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270490AbTGNBkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 21:40:45 -0400
Received: from dsl093-061-108.pit1.dsl.speakeasy.net ([66.93.61.108]:62462
	"EHLO o-o.yi.org") by vger.kernel.org with ESMTP id S270489AbTGNBko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 21:40:44 -0400
X-Mailer: exmh version 2.5 10/15/1999 with nmh-1.0.4
To: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend 
 enhancements
In-Reply-To: Message from Jamie Lokier <jamie@shareable.org> 
   of "Mon, 14 Jul 2003 02:43:28 BST." <20030714014328.GB22769@mail.jlokier.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Jul 2003 21:55:26 -0400
From: Lyle Seaman <lws@o-o.yi.org>
Message-Id: <20030714015531.7F1CF14829@o-o.yi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Haven't you ever pressed the "off" or "lock" button on a computer in a
> lab and walked away?

Yes, I have, but that's not what I was driving at.  The question is, what do 
you think is the difference between :

(a) pressing "suspend" and walking away, while being assured that suspend will 
complete and leave the system ... suspended, until someone triggers a "resume"

and

(b) pressing "suspend" and walking away, while allowing the possibility that 
someone might interrupt the suspend operation.

??

Personally, I don't see any difference.



