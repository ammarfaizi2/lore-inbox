Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUIIUrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUIIUrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUIIUrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:47:20 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:28319 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S266115AbUIIUrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:47:08 -0400
Date: Thu, 9 Sep 2004 21:45:56 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Hans Reiser <reiser@namesys.com>
cc: "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
 the idea ofwhat reiser4 wants to do with metafiles and why
In-Reply-To: <4140ABB6.6050702@namesys.com>
Message-ID: <Pine.LNX.4.61.0409092136160.23011@fogarty.jakma.org>
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com>
 <Pine.LNX.4.58.0409071658120.2985@sparrow> <200409080009.52683.robin.rosenberg.lists@dewire.com>
 <20040909090342.GA30303@thunk.org> <4140ABB6.6050702@namesys.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2004, Hans Reiser wrote:

> Putting \ into filenames makes windows compatibility less trivial.

Err, I think Ted used \ as an example of how to escape |. It is not 
part of the filename.

> Putting | into filenames seems like asking for trouble with shells.

I think that was Ted's precise reason for arguing that | be used. Did 
you even read his rationale? :)

> If you think \| is user friendly, oh god, people like you are the 
> reason why Unix is hated by many.

I think he was arguing | (not \|) is the least worst seperator to 
use.

> Rather few people understand closure though, so I don't expect to 
> do well in the politics of this. It is a bit like being for free 
> trade, most people will never understand why it is so important 
> because their mental gifts are in other matters,

Lots of people understand why free-trade is important. It's taught in 
introductory economics/business classes in secondary school.

If you are similarly underestimating the understanding of those who 
are debating merits of in-name-space streams with you, and 
overestimating your own understanding, you're not going make progress 
in convincing people of their merit (if at all).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
The only way to keep your health is to eat what you don't want, drink what
you don't like, and do what you'd rather not.
 		-- Mark Twain
