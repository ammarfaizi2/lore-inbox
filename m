Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVJFT3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVJFT3U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVJFT3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:29:20 -0400
Received: from free.hands.com ([83.142.228.128]:53971 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1751334AbVJFT3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:29:19 -0400
Date: Thu, 6 Oct 2005 20:28:57 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Michael Concannon <mike@concannon.net>
Cc: Chase Venters <chase.venters@clientec.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051006192857.GV10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <200510041840.55820.chase.venters@clientec.com> <20051005102650.GO10538@lkcl.net> <200510060005.09121.chase.venters@clientec.com> <43453E7F.5030801@concannon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43453E7F.5030801@concannon.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 11:10:55AM -0400, Michael Concannon wrote:

> All good points, but perhaps the most compelling to me is that virtually 
> every successful windows virus out there does its real damage by 
> modifying the registry to replace key actions, associate bad actions 
> with good ones and just generally screw the system up...
 
 the damage is done because "admin" rights are forced out of the control
 of the users and sysadmins and into the hands of the dumb-ass app
 writers, for both the setup stage and then the actual day-to-day
 usage of the app!

 the registry on NT has ACLs - which are completely irrelevant as far as
 users running as admin are concerned (because the dumb-ass app writers
 force them to).

 the nt registry - imagine it to be .... _like_ a filesystem, or _like_
 an LDAP server.

 except with proper ACLs and access controls [which everyone bypasses
 because duh it's windows duh, not because it's impossible to do a decent
 job with the API and its implementation].

 l.

