Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWJCDh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWJCDh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 23:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWJCDh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 23:37:57 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:53700 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S932241AbWJCDh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 23:37:56 -0400
Date: Mon, 2 Oct 2006 20:37:56 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Lee Revell <rlrevell@joe-job.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
In-Reply-To: <20061002173951.GA8534@codepoet.org>
Message-ID: <Pine.LNX.4.64.0610022029010.32183@twinlark.arctic.org>
References: <1159539793.7086.91.camel@mindpipe> <20061002100302.GS16047@mea-ext.zmailer.org>
 <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org>
 <1159804137.4067.144.camel@mindpipe> <20061002173951.GA8534@codepoet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006, Erik Andersen wrote:

> On Mon Oct 02, 2006 at 11:48:57AM -0400, Lee Revell wrote:
> > You could also flag a very short message that contains a URL and is not
> > a reply to an existing thread - I can't think of a legitimate post to
> > LKML fitting this pattern.
> 
> Blocking emails containing URLs pointing to domains registered
> less than a week ago would block most of the recent spams.

unless they changed pattern the past week this wouldn't work... two weeks 
ago the domains from the 1-liner porn spams were registered 3 or 4 months 
ago.  i checked a dozen+ of them looking for anything useful for 
filtering.

if you visited the urls they lead to the same web page text -- something 
so obviously a porn front-door even bayes could have got it right.  (i.e. 
"are you 18?").

it sure would be nice if posting were subscribers-only.

-dean
