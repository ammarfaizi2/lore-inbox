Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUIAGDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUIAGDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 02:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUIAGDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 02:03:54 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:10180 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264531AbUIAGDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 02:03:53 -0400
Message-ID: <4135664C.1070406@namesys.com>
Date: Tue, 31 Aug 2004 23:03:56 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: V13 <v13@priest.com>
CC: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, reiserfs-list@namesys.com
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
 the idea of what reiser4 wants to do with metafiles and why
References: <41323AD8.7040103@namesys.com> <200408312055.56335.v13@priest.com>
In-Reply-To: <200408312055.56335.v13@priest.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

V13 wrote:

>
>
>  AFAIK and AFAICS the metadata are not files or directories.
>
Yes they are. In reiser4. They might be stored different, but their 
interface is what counts.

