Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbUJXFOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbUJXFOb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 01:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbUJXFOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 01:14:30 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:53902 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261373AbUJXFO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 01:14:29 -0400
Message-ID: <417B3A34.2060306@namesys.com>
Date: Sat, 23 Oct 2004 22:14:28 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.6.9-mm1
References: <20041023165712.GR26192@nysv.org> <417B1574.4090406@slaphack.com>
In-Reply-To: <417B1574.4090406@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>
> Some people don't care about speed but need space.  I'd leave them in on
> general principle, even if no one wants them now.

Software design is usually improved by identifying features that aren't 
worth much, and removing them from the interface and burying them where 
average users don't see them (or dumping them completely).  Interface 
clutter has a cost.

Hans
