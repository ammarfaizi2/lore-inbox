Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVETUes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVETUes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVETUes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:34:48 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:61829 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S261578AbVETUei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:34:38 -0400
Date: Fri, 20 May 2005 23:34:30 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: ted creedon <tcreedon@easystreet.com>
cc: openafs-info@openafs.org, linux-kernel@vger.kernel.org
Subject: RE: [OpenAFS] Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same
 for 2.4.30 and openafs 1.3.82
In-Reply-To: <20050520191207.15E3D29528@smtpauth.easystreet.com>
Message-ID: <Pine.LNX.4.62.0505202326440.5106@tassadar.physics.auth.gr>
References: <20050520191207.15E3D29528@smtpauth.easystreet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.30.0.12; VDF: 6.30.0.188; host: tassadar)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Gcc -dumpmachine  #should prints out i586-suse-linux for a P III here.

here it prints: i486-slackware-linux
>
> I'd try a fresh single processor machine and force a 2.6 kernel, module and
> afs recompile for a i586.
>
> SuSE 9.3 costs $90 and it solved a similar problem noted in the mailings. In
> fact the YasT installed openafs binaries ran fine.

 	Do you have any pointers to Suse's solution and source code?I 
could check what they did and try it...

> The ksymoops man page has a script to tail -f /var/log/messages|ksymoops1
> explained.

 	I will try that , thnx :)

> Are you sure there isn't a memory problem? I'm running out of ideas.
> tedc

 	It's been a while since I memtested the box , I will try that also 
when I return at the office ( in about a week).



--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
=============================================================================

