Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbTA0TzJ>; Mon, 27 Jan 2003 14:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267299AbTA0TzJ>; Mon, 27 Jan 2003 14:55:09 -0500
Received: from twinlark.arctic.org ([208.44.199.239]:2272 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S267289AbTA0TzI>; Mon, 27 Jan 2003 14:55:08 -0500
Date: Mon, 27 Jan 2003 12:04:26 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Balbir Singh <balbir_soni@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Patches have a license
In-Reply-To: <20030127104705.GC25913@codemonkey.org.uk>
Message-ID: <Pine.LNX.4.53.0301271153560.2745@twinlark.arctic.org>
References: <20030127095840.25042.qmail@web13601.mail.yahoo.com>
 <20030127104705.GC25913@codemonkey.org.uk>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Dave Jones wrote:

> On Mon, Jan 27, 2003 at 01:58:40AM -0800, Balbir Singh wrote:
>  > I would request everyone to post their patches with
>  > a license, failing which it should be assumed that
>  > the license is GPL.
>
> Surely the license of the diff matches the license of the
> code it is patching ?

no... actually the diff poster retains their own copyright on the diff
unless they specify otherwise.  so not only would folks using them in
proprietary code would have to ask your permission to use the patch, but
so should linus request you to release it under GPL.

although it's somewhat tongue in cheek, check the url i include on all
messages i send -- <http://arctic.org/~dean/legal>.

i'm not sure if they still do it, but when IBM started contributing to the
apache project, every patch they posted included a disclaimer and release
under the apache license.

also FSF requires a release form on file from you to accept any patch.
(i've also got a form on file with the ASF which i think formalises this
copyright issue for core group members.)

in the end i'm sure you could argue your intent was clear and implicit,
but some folks prefer to be explicit.

-dean
