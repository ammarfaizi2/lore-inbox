Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423409AbWJZFek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423409AbWJZFek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 01:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423416AbWJZFek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 01:34:40 -0400
Received: from main.gmane.org ([80.91.229.2]:47779 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423409AbWJZFej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 01:34:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [git failure] failure pulling latest Linus tree
Date: Thu, 26 Oct 2006 05:34:26 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnek0iji.93p.olecom@flower.upol.cz>
References: <yq0d58g92u0.fsf@jaguar.mkp.net> <Pine.LNX.4.64.0610250746000.3962@g5.osdl.org> <453F8630.2000608@zytor.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-25, H. Peter Anvin wrote:
> Linus Torvalds wrote:
>> 
>> On Wed, 25 Oct 2006, Jes Sorensen wrote:
>>> Known error? git tree corrupted or need for a new version of git?
>> 
>> For some reason, the mirroring seems to be really slow or broken to one of 
>> the public servers (zeus-pub1). It looks to be affecting gitweb too (ie 
>> www1.kernel.org is busted, while www2.kernel.org seems ok)
>> 
>
> For some reason which we haven't been able to track down yet, the recent 
> load imposed by FC6 caused zeus1's load to skyrocket, but not zeus2's... 
> it's largely a mystery.
>
> HOWEVER, git 1.4.3 seems to have been bad chicken.  When we ran it we 
> got a neverending stream of segfaults in the logs.

Please, are there more gitweb services of kernel.org's one?

I know this may be stupid as anyone can git clone && etc. But in my
case all i need (mostly) is history and logs (i've started my devel
from patches, and they are mirrored pretty good).

TIA.

-o--=O`C  /. .\
 #oo'L O      o
<___=E M    ^--

