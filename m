Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUJVUUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUJVUUt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbUJVUTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:19:35 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:48834 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S267376AbUJVUO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:14:58 -0400
Message-ID: <41796178.7010006@drdos.com>
Date: Fri, 22 Oct 2004 13:37:28 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Weinehall <tao@acc.umu.se>, Dax Kelson <dax@gurulabs.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com> <20041022090752.GA1308@khan.acc.umu.se> <41793204.9090208@drdos.com> <20041022175233.GY24336@parcelfarce.linux.theplanet.co.uk> <417941C7.1030207@drdos.com>
In-Reply-To: <417941C7.1030207@drdos.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

SCO Just sent over a list of contaminated files with a "bill of health" 
certification for Linux that if we remove the identified files
they will certify our Linux distribution as clean. They are also sending 
out some form of statement that we are
not affiliated with them, and that we are competitors of SCO since we 
use Linux. They claim the following and I have
a listing of files, lines numbers, etc. they told us we must remove in 
order for our Linux appliances to be considered
"clean." This info might be useful to others. They have a cert program 
to remove the areas.

Here it is. I can get the line numbers of the file and their names if 
anyone needs it, but the list is very big.

RCU
46 files
109,688 lines

NUMA
101 files
56,587 lines

JFS
44 files
32,224 lines

XFS
173 Files
119,130 lines

SMP
1,185 files
829,393 lines

Total files/lines they [allege] contains SCO source code
1,549 files
1,147,022 lines

If you guys want the specific line numbers and filenames, I will ask 
them to post the specific filenames/line numbers they claim
are theirs. They stated we can ship Linux with fear of being sued if we 
comply with their Linux Certification Program.


