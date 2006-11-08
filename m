Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423806AbWKHWNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423806AbWKHWNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161743AbWKHWNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:13:45 -0500
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:58574 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1161742AbWKHWNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:13:44 -0500
Message-ID: <455256A2.1020505@slaphack.com>
Date: Wed, 08 Nov 2006 16:13:54 -0600
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Suzuki <suzuki@linux.vnet.ibm.com>
CC: reiserfs-list@namesys.com, lkml <linux-kernel@vger.kernel.org>,
       Jan Kara <jack@suse.cz>
Subject: Re: Problem with multiple mounts
References: <45522E67.7050907@linux.vnet.ibm.com>
In-Reply-To: <45522E67.7050907@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suzuki wrote:

> "I exported a disk partition using nbd protocol.

Why?

I don't mean it's completely absurd, I'd just like to know what the 
reason is for not using NFS. Perhaps you should look at DRBD?

What is the real goal here?
