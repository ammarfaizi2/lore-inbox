Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267594AbUG2QRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267594AbUG2QRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267589AbUG2QPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:15:08 -0400
Received: from jade.spiritone.com ([216.99.193.136]:29096 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268617AbUG2QNv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:13:51 -0400
Date: Thu, 29 Jul 2004 09:13:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       jbarnes@engr.sgi.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <155280000.1091117590@[10.10.2.4]>
In-Reply-To: <m1vfg6kdzi.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au><20040725235705.57b804cc.akpm@osdl.org><m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com><200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay><m14qnr7u7b.fsf@ebiederm.dsl.xmission.com><20040728133337.06eb0fca.akpm@osdl.org><1091044742.31698.3.camel@localhost.localdomain><m1llh367s4.fsf@ebiederm.dsl.xmission.com><20040728164457.732c2f1d.akpm@osdl.org><133880000.1091110104@[10.10.2.4]> <m1vfg6kdzi.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > We really want to get into the new kernel ASAP and clean stuff up from
>> > in there.
>> 
>> As long as the "init" routines are run on every startup (not just kexec ones),
>> they should get plenty of testing (though not from bad card state).
> 
> And I know for a fact that many init routines won't initialize a
> card in a bad state currently.  That is my most frequent failure in
> the normal kexec case, when things are not in a 

Oh, yes, I know that ... I'm just saying we should fix it ;-)

M.

