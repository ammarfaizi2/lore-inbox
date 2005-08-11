Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVHKLAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVHKLAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbVHKLAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:00:25 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:50599 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030261AbVHKLAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:00:24 -0400
Message-ID: <42FB2FE8.6040403@gentoo.org>
Date: Thu, 11 Aug 2005 12:00:56 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joseph Fannin <jfannin@gmail.com>
Cc: Kristoffer <kfs1@online.no>, linux-kernel@vger.kernel.org
Subject: Re: captive-ntfs FUSE support?
References: <op.svanygid3czpo8@myhost.localdomain> <42FA364C.9090605@gentoo.org> <20050811013604.GA29515@nineveh.rivenstone.net>
In-Reply-To: <20050811013604.GA29515@nineveh.rivenstone.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Fannin wrote:
>     I haven't seen any real changes in NTFS support in the kernel since
> the mid-2.5 series.  Is there somewhere else I should be looking?

The development tree is here:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/aia21/ntfs-2.6-devel.git;a=summary

Right now, I think most(/all?) of the patches have been merged into 2.6.13.

Daniel
