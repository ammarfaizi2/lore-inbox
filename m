Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUHRM24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUHRM24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUHRMZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:25:52 -0400
Received: from stacja.kursor.pl ([80.55.191.138]:36284 "EHLO stacja.kursor.pl")
	by vger.kernel.org with ESMTP id S266181AbUHRMZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:25:28 -0400
Date: Wed, 18 Aug 2004 14:24:43 +0200 (CEST)
From: Janusz Dziemidowicz <rraptorr@kursor.pl>
To: Diego Calleja <diegocg@teleline.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext3 documentation (lack of)
In-Reply-To: <20040818133818.7b0582f3.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.61.0408181414450.18542@stacja.kursor.pl>
References: <20040818025951.63c4134e.diegocg@teleline.es>
 <200408172301.09350.ryan@spitfire.gotdns.org> <20040818133818.7b0582f3.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004, Diego Calleja wrote:

> (It'd be nice if people could provide a description for the rest so we can
> recollect and submit them)

AFAIK
user_xattr - turns on POSIX Extended attributes
nouser_xattr - obvious
acl - turns on ACL (Access Control Lists)
noacl - obvious

However these features are only present in 2.6.x, they are explained in 
Help during kernel configuration. I'm not sure if acl requires user_xattr 
to be turned on. I remember that I spent some time looking for a way to 
enable these on ext2/ext3 :)

--
Janusz Dziemidowicz
rraptorr@kursor.pl

