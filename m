Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUG2Hfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUG2Hfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 03:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUG2Hfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 03:35:51 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:5030 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266768AbUG2Hfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 03:35:48 -0400
Message-ID: <4108A8D4.2070602@namesys.com>
Date: Thu, 29 Jul 2004 00:35:48 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfrench@austin.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: XATTR support
References: <1091062286.2363.10.camel@smfhome.smfdom>
In-Reply-To: <1091062286.2363.10.camel@smfhome.smfdom>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:

>I noticed that ext2, ext3, reiserfs, and jfs mark (in menuconfig) their
>xattr support as an optional subfeature which is a little surprising
>because the xattr support in those filesystems is no longer
>experimental/unstable
>
well, xattr related bugs were found just a few months ago.... and some 
of us think xattrs are a bad idea in principle.

