Return-Path: <linux-kernel-owner+w=401wt.eu-S1750696AbXAUPKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbXAUPKH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 10:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbXAUPKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 10:10:06 -0500
Received: from main.gmane.org ([80.91.229.2]:37315 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbXAUPKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 10:10:05 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Followup-To: gmane.comp.version-control.git
Date: Sun, 21 Jan 2007 16:06:22 +0100
Organization: At home
Message-ID: <eovvg3$i6m$1@sea.gmane.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <20070121134308.GA24090@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Cc: git@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sun, Jan 21, 2007 at 03:20:06AM -0800, Junio C Hamano wrote:

>> BTW, as the upcoming v1.5.0 release will introduce quite a bit of
>> surface changes (although at the really core it still is the old
>> git and old ways should continue to work), I am wondering if it
>> would help people to try out and find wrinkles before the real
>> thing for me to cut a tarball and a set of RPM packages.
>> 
>> Comments?
> 
> Anything you can do to make tester's life easier will always slightly
> increase the number of testers. Hint: how often do you try random
> software that requires that you first install CVS, SVN or arch just to
> get it, compared to how often you try random software provided as tar.gz ?
> Pre-release tar.gz and rpms coupled with a freshmeat announcement should
> get you a bunch of testers and newcomers. This will give the new doc a
> real trial, and will help discover traps in which beginners often fall.

RPMS are nicely divided into (sub)packages, so you need CVS indtalled
only if you install git-cvs package, for example to interact with CVS.
git-core has minimal dependencies.

To compile git you truly don't need other software installed (1.5.0
for example does not require RCS anymore for RCS merge).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git


