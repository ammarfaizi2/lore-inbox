Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbTGGDSs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 23:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266800AbTGGDSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 23:18:48 -0400
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:9856 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP id S266798AbTGGDSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 23:18:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops with .74 snapshot.
In-Reply-To: <1057540770.215922@palladium.transmeta.com> (Linus Torvalds's
 message of "Sun, 06 Jul 2003 18:19:29 -0700")
References: <87n0frp4v1.fsf@enki.rimspace.net>
	<1057540770.215922@palladium.transmeta.com>
From: Daniel Pittman <daniel@rimspace.net>
Date: Mon, 07 Jul 2003 13:33:23 +1000
Message-ID: <874r1z3ta4.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (cassava)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jul 2003, Linus Torvalds wrote:
> Daniel Pittman wrote:
>>
>> I got the following series of oops reports when booting a .74
>> snapshot. Following is information on the latest changeset in the CVS
>> export server, and the reports.
> 
> Just out of interest, does this fix it for you? It looks sane, but
> since David is off for the weekend, I don't want to apply it without
> some serious feedback that "yes, it fixes the problem".

Yes. With that applied, all the problems are gone.
     Daniel

-- 
We wait and think that we are biding our time.
We keep silent, we believe in our strength.
We trust in propaganda of the wonders of tomorrow 
in the shadow of content we are victims in the end. 
        -- Covenant, _Theremin_
