Return-Path: <linux-kernel-owner+w=401wt.eu-S1030396AbWLTWYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWLTWYf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWLTWYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:24:35 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:17727 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030396AbWLTWYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:24:33 -0500
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: What's in git.git (stable), and Announcing GIT 1.4.4.3
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
From: merlyn@stonehenge.com (Randal L. Schwartz)
Date: 20 Dec 2006 14:04:29 -0800
In-Reply-To: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
Message-ID: <86vek6z0k2.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> * The 'master' branch has these since the last announcement.
Junio>   They are NOT in 1.4.4.3.

Junio>       index-pack usage of mmap() is unacceptably slower on many OSes
Junio>          other than Linux

Is this really in master?  I'm still seeing one-hour times on
my Mac, using 8336afa563fbeff35e531396273065161181f04c.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
