Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVLJCBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVLJCBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVLJCBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:01:37 -0500
Received: from web31712.mail.mud.yahoo.com ([68.142.201.192]:36236 "HELO
	web31712.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750720AbVLJCBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:01:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=A2YiaAol2giVvB3Rmv3fIS4J+1p8MvklC2tBkxBf7N+NNTwd1wtSw06EAOGIt+TzJYuDQD0czwpKGZ0ru98KCm4yIhsG8x4VyOaFrDj69ljI0YtUxnrqwkh+hllOQiqUoC5QQahN/xCEc62TP7htsNy/PZCvLBkhakhB4JviDOk=  ;
Message-ID: <20051210020134.94755.qmail@web31712.mail.mud.yahoo.com>
Date: Fri, 9 Dec 2005 18:01:34 -0800 (PST)
From: Bao Zhao <baozhaolinuxer@yahoo.com>
Subject: typo in debugfs code comments?
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I think that the comments of debugfs_create_u16 and
debugfs_create_u32 
have the copy and paste error.
  
below is original comments.
/**
 * debugfs_create_u16 - create a file in the debugfs
filesystem that is used to read and write a unsigned 8
bit value.
 *

/**
 * debugfs_create_u32 - create a file in the debugfs
filesystem that is used to read and write a unsigned 8
bit value.
 *

It should be "a unsigned 16 bit value" and "a unsigned
32 bit value"

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
