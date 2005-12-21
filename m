Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVLUMgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVLUMgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 07:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVLUMgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 07:36:09 -0500
Received: from ns1.suse.de ([195.135.220.2]:50090 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932216AbVLUMgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 07:36:08 -0500
Date: Wed, 21 Dec 2005 13:35:56 +0100
From: Olaf Hering <olh@suse.de>
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 0.99.9n aka 1.0rc6
Message-ID: <20051221123556.GA20431@suse.de>
References: <7v7ja7rsqv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7v7ja7rsqv.fsf@assigned-by-dhcp.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Dec 14, Junio C Hamano wrote:

> No more big changes from now on will be merged to the "master"
> branch, except fixes and documentation enhancements.

Can you add a 'git bisect doesnotcompile' at some point? Just marking
one commit as bad will not work, because the next offer may not compile
either.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
