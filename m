Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269252AbUICEni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269252AbUICEni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 00:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269230AbUICEni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 00:43:38 -0400
Received: from pointblue.com.pl ([81.219.144.6]:39179 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S269153AbUICEne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 00:43:34 -0400
Message-ID: <4137F669.2000505@pointblue.com.pl>
Date: Fri, 03 Sep 2004 06:43:21 +0200
From: =?UTF-8?B?R3J6ZWdvcnogSmHFm2tpZXdpY3o=?= <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?TWFya3VzIFTDtnJucXZpc3Q=?= <mjt@nysv.org>
Cc: Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org>
In-Reply-To: <20040826075348.GT1284@nysv.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Törnqvist wrote:

>On Thu, Aug 26, 2004 at 12:32:00AM -0500, Matt Mackall wrote:
>  
>
>>Find some silly person with an iBook and open a shell on OS X. Use cp
>>to copy a file with a resource fork. Oh look, the Finder has no idea
>>what the new file is, even though it looks exactly identical in the
>>shell. Isn't that _wonderful_? Now try cat < a > b on a file with a
>>fork. How is that ever going to work?
>>    
>>
>
>Then I guess OS X ships a broken implementation of cp, yes?
>
>  
>
Nope, GUI handles it perfectly. it's maybe 0.1% of users of MacOS that acctually care about cp being broken.

--
GJ 

