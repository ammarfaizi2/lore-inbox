Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266042AbUFJASN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbUFJASN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUFJASN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:18:13 -0400
Received: from mail.aei.ca ([206.123.6.14]:59120 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266042AbUFJASK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:18:10 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Wed, 9 Jun 2004 20:17:58 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
References: <1085689455.7831.8.camel@localhost> <200406091944.15082.edt@aei.ca> <20040609165231.151e84e7.akpm@osdl.org>
In-Reply-To: <20040609165231.151e84e7.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406092017.58582.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On June 9, 2004 07:52 pm, Andrew Morton wrote:
> Ed Tomlinson <edt@aei.ca> wrote:
> >
> > Hi,
> > 
> > I am still seeing these with 7-rc3-mm1...  No extra diag info either.   I would be
> > really nice to see this one fixed.
> 
> So ide-print-failed-opcode.patch isn't working.  Presumably
> HWGROUP(drive)->rq is null.

No change from the first time I tried the patch.

Ed
