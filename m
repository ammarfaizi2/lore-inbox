Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270715AbTHALMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 07:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270720AbTHALMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 07:12:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36915 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S270715AbTHALMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 07:12:12 -0400
To: Robert Love <rml@tech9.net>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: [PATCH] protect migration/%d etc from sched_setaffinity
References: <20030731224604.GA24887@tsunami.ccur.com>
	<1059692548.931.329.camel@localhost>
	<20030731230635.GA7852@rudolph.ccur.com>
	<1059693499.786.1.camel@localhost>
	<20030731231850.GC7378@werewolf.able.es>
	<1059694637.786.11.camel@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Aug 2003 05:09:00 -0600
In-Reply-To: <1059694637.786.11.camel@localhost>
Message-ID: <m1u191ws6r.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> writes:

> On Thu, 2003-07-31 at 16:18, J.A. Magallon wrote:
> 
> > Er, why 'she' ?
> > In spanish we use root==admin as male, and root==tree or plant root,
> > as female.
> 
> In English, the pronoun refers to the sex of the person. These is no
> gender of words like in Spanish (i.e., a dog is a dog).
> 
> So, since administrators come in both sexes, I picked one.

Except the convention in English is to use the male in that case.
Using the female pronoun tends to distract from the point.

There are plenty of plural forms that do not imply gender at all.
As in:

> Yah, I know. But this is a lot of code just to prevent root users from hanging
> themselves, and there are plenty of other ways they can do that.

Eric
