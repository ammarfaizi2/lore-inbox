Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUIJA5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUIJA5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUIJA5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:57:20 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:8429 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266582AbUIJA5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:57:12 -0400
Message-ID: <4140FBE7.6020704@namesys.com>
Date: Thu, 09 Sep 2004 17:57:11 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
 the idea ofwhat reiser4 wants to do with metafiles and why
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com> <Pine.LNX.4.58.0409071658120.2985@sparrow> <200409080009.52683.robin.rosenberg.lists@dewire.com> <20040909090342.GA30303@thunk.org> <4140ABB6.6050702@namesys.com> <Pine.LNX.4.61.0409092136160.23011@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.61.0409092136160.23011@fogarty.jakma.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:

> On Thu, 9 Sep 2004, Hans Reiser wrote:
>
>> Putting \ into filenames makes windows compatibility less trivial.
>
>
> Err, I think Ted used \ as an example of how to escape |. It is not 
> part of the filename.

It is not part of it at one level, but in the shell it is part of it.

>
>> Putting | into filenames seems like asking for trouble with shells.
>
>
> I think that was Ted's precise reason for arguing that | be used. Did 
> you even read his rationale? :)

That trouble is desirable? Yes, I can understand why he might not want 
things to work well.;-)

>
>> If you think \| is user friendly, oh god, people like you are the 
>> reason why Unix is hated by many.
>
>
> I think he was arguing | (not \|) is the least worst seperator to use.
>
>> Rather few people understand closure though, so I don't expect to do 
>> well in the politics of this. It is a bit like being for free trade, 
>> most people will never understand why it is so important because 
>> their mental gifts are in other matters,
>
>
> Lots of people understand why free-trade is important. It's taught in 
> introductory economics/business classes in secondary school.

Have you looked at the political process at all? Or by lots of people, 
do you mean a sizable minority?


