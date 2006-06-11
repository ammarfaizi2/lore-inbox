Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWFKNzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWFKNzU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 09:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWFKNzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 09:55:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1202 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751307AbWFKNzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 09:55:19 -0400
Date: Sun, 11 Jun 2006 09:55:10 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Theodore Tso <tytso@mit.edu>
cc: David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
In-Reply-To: <20060611130249.GA10606@thunk.org>
Message-ID: <Pine.LNX.4.64.0606110952560.29891@cuia.boston.redhat.com>
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
 <1149980791.18635.197.camel@shinybook.infradead.org>
 <Pine.LNX.4.64.0606102015410.30593@cuia.boston.redhat.com>
 <20060611130249.GA10606@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2006, Theodore Tso wrote:

> Actually, I post as "tytso@mit.edu" (but always relayed through my
> mail relay at thunk.org).  :-)

That will no longer work reliably if Matti enables SPF, 
since thunker.thunk.org is not in the mit.edu SPF record.
At least it's not a -all...

-- 
All Rights Reversed
