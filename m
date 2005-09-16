Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161141AbVIPJTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbVIPJTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 05:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbVIPJTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 05:19:04 -0400
Received: from web51001.mail.yahoo.com ([206.190.38.132]:56411 "HELO
	web51001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161141AbVIPJTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 05:19:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YQYp9QgFxzIVM/CfeMWI7zx0sSMhoEz2jdSqluc0P2vaJVT0dehIQGj2hcrdtlEEZGj3cdaWTNGbZm+elY1TxyrgxcG59C5hvw9xXUMDTZYQ4EuFnNd8+oqYaWj/7UD4wvt6gH5j0TI32qmU49xUYDOk1g04djc8HjMm/9zhYx0=  ;
Message-ID: <20050916091901.33375.qmail@web51001.mail.yahoo.com>
Date: Fri, 16 Sep 2005 02:19:01 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
To: Emmanuel Fleury <fleury@cs.aau.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <432A874F.7040806@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Emmanuel Fleury <fleury@cs.aau.dk> wrote:

> Ahmad, as far as I understood, your spirit is more
> or less to:
> 
> - Drop automagically all the hardware which is for
> sure NOT here
> - Propose to the user to include the hardware which
> is detected
> - Leave as default the rest of the choices
>   (i.e. the choices that might be uncertain: fs,
> protocols, ...)
> 
> Therefore, "make autoconfig" is a quick first run
> through the .config
> with the help of all the scripts stored in
> scripts/autoconfig/.
> 

Yes your right about that.
But I want to tell why I came to this Idea of doing
that. As I was trying to configurate a Kernel for the
first time but without any success. Then I thought
about it, why this cannot be automatically.

So for the first thought, my spirit of doing this, was
for those who doesn't know e.g. what the option
"Enable loadable module support" means and if they
have to choose that or not. But right now I know that
it is not possible to do all the things
automatically(like the filesystem, Protokolls...). And
that is the reason why I make a Framework, so
everybody(I mean the experts) can give theire
suggestion what isthe best way to answering, a optione
like mention above comes, automatically. So if someone
wants to use a new kernel didn't end up desperate and
regrated using Linux(a new Kernel).

Regards

Ahmad Reza

 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
