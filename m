Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270851AbTHARet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 13:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270852AbTHARet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 13:34:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61235 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S270851AbTHARer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 13:34:47 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Robert Love <rml@tech9.net>, "J.A. Magallon" <jamagallon@able.es>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: [PATCH] protect migration/%d etc from sched_setaffinity
References: <20030731224604.GA24887@tsunami.ccur.com>
	<1059692548.931.329.camel@localhost>
	<20030731230635.GA7852@rudolph.ccur.com>
	<1059693499.786.1.camel@localhost>
	<20030731231850.GC7378@werewolf.able.es>
	<1059694637.786.11.camel@localhost>
	<m1u191ws6r.fsf@frodo.biederman.org>
	<20030801161529.GB12501@mail.jlokier.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Aug 2003 11:31:43 -0600
In-Reply-To: <20030801161529.GB12501@mail.jlokier.co.uk>
Message-ID: <m1ptjpwagw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > > So, since administrators come in both sexes, I picked one.
> > 
> > Except the convention in English is to use the male in that case.
> > Using the female pronoun tends to distract from the point.

> As you can see from the latter two examples, a word _itself_ does not
> imply a linguistic sex.  The role is what is significant.

To some extent.  To some extent before people started ``correcting''
the situation the masculine pronoun was on it's way to becoming
gender neutral in English. 

In a similar case sir has become vendor neutral in some contexts.
I need to review what has actually happened in the armed services
to see if a vendor neutral usage has caught on at large.  But it is
encouraging to see that things like this can happen.

> Many people don't like the stereotyping, and the (significant) social
> inequality which is reinforced by this, and choose to do their bit to
> alter (possibly correct) the collective view of how things are, or
> ought to be.

Same here.
 
> You're right that it distracts from the point, but then to _not_
> distract from the point is to perpetuate social inequality, or
> something like that...

It lowers my opinion of someone when they do not want to perpetuate
stereo types and yet cannot rephrase a sentence in a gender neutral
way, in English.

> > There are plenty of plural forms that do not imply gender at all.
> > As in:
> > 
> > > Yah, I know. But this is a lot of code just to prevent root users from
> hanging
> 
> > > themselves, and there are plenty of other ways they can do that.
> 
> That is the most neutral.  Alas, plurals are often that bit more
> cumbersome and dry.  Depends whether you're evoking a reference manual
> or a personal story, I guess :)

So brining this back on topic.   Given that plurals are gender neutral,
and that there are gender neutral words like person and people.  When doing
kernel documentation please do it in a gender neutral way.

Eric
