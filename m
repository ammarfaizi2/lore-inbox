Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268407AbTGIQWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268412AbTGIQWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:22:13 -0400
Received: from mail.ithnet.com ([217.64.64.8]:13063 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S268407AbTGIQVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:21:33 -0400
Date: Wed, 9 Jul 2003 18:36:02 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: green@namesys.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030709183602.7083dd82.skraw@ithnet.com>
In-Reply-To: <20030709154015.GJ150921@niksula.cs.hut.fi>
References: <20030706183453.74fbfaf2.skraw@ithnet.com>
	<1057515223.20904.1315.camel@tiny.suse.com>
	<20030709140138.141c3536.skraw@ithnet.com>
	<1057757764.26768.170.camel@tiny.suse.com>
	<20030709134837.GJ18307@namesys.com>
	<20030709154015.GJ150921@niksula.cs.hut.fi>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003 18:40:15 +0300
Ville Herva <vherva@niksula.hut.fi> wrote:

>> > ok, I did the reiserfsck and it works flawlessly. No errors no problems no
> > hang.
> > I tried mount afterwards and it still hangs.
> > Is there some recent change around the mount procedure itself? maybe it is
> > really unrelated to reiserfs and 3ware...
> 
> Is it just this partition or any reiserfs fs on 3ware?

Hm, unfortunately I can't tell, I have no other partition available on 3ware
...

> > Oleg Drokin <green@namesys.com> wrote:
> > > Then next step would be probably to try and mount the partition from
> > > usermodelinux if you are able to conduct such a test.
> 
> It it possible to mount raw partitions with UML?

Hm, I never tried UML. I really wonder if there is nobody else with 3ware and
reiserfs available for re-checking 2.4.22-pre3. Only to see if this is a
singular problem or reproducable elsewhere.

Regards,
Stephan
