Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbSJPTEt>; Wed, 16 Oct 2002 15:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSJPTEt>; Wed, 16 Oct 2002 15:04:49 -0400
Received: from web12903.mail.yahoo.com ([216.136.174.70]:35751 "HELO
	web12903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261273AbSJPTEs>; Wed, 16 Oct 2002 15:04:48 -0400
Message-ID: <20021016191045.47426.qmail@web12903.mail.yahoo.com>
Date: Wed, 16 Oct 2002 12:10:45 -0700 (PDT)
From: Daniel Zinder <danielzinder@yahoo.com>
Subject: How to allow caching of PCI addresses in user space?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently working on a univ. project which
requires caching of data stored on a remote computer
and accessed via PCI address mmapping to userspace.

I have repeatdly failed to enable caching of these
addresses. 

The mmaping is done using remap_page_range.
I have tried various protection options without
success. 

Does this have to do with anything concerning the
MTRR's? 

How can I allow caching of PCI addresses accessed in
user space thorugh mmaping using remap_page_range?

Thanks,
Daniel Zinder
 

__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
