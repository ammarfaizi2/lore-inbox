Return-Path: <linux-kernel-owner+w=401wt.eu-S1161135AbWLUByv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWLUByv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbWLUByt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:54:49 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:24770 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161131AbWLUBys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:54:48 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: What's in git.git (stable), and Announcing GIT 1.4.4.3
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
From: merlyn@stonehenge.com (Randal L. Schwartz)
Date: 20 Dec 2006 15:58:38 -0800
In-Reply-To: <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
Message-ID: <86ejquxgpd.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> Master right  now is at 54851157ac.

On a more positive note, with my local (unacceptable) changes to muck with
headers, the 54 release does in fact make git-index-pack take
under a minute for 313037 objects on OSX.  Yeay!

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
