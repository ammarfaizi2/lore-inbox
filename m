Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbTENMzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbTENMzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:55:33 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:26131 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262134AbTENMzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:55:32 -0400
To: zhangtao <zhangtao@zhangtao.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About NLS Codepage 932
References: <20030512100534.1ba6ecd6.zhangtao@zhangtao.org>
	<1052737621.31246.7.camel@dhcp22.swansea.linux.org.uk>
	<20030513101740.626a06a5.zhangtao@zhangtao.org>
	<87d6int4qx.fsf@devron.myhome.or.jp>
	<20030514093318.0d8d1564.zhangtao@zhangtao.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 14 May 2003 22:08:11 +0900
In-Reply-To: <20030514093318.0d8d1564.zhangtao@zhangtao.org>
Message-ID: <878yt9oev8.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zhangtao <zhangtao@zhangtao.org> writes:

> On Tue, 13 May 2003 21:23:18 +0900
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> 
> OK, Thanks!
> 
> I want to know how Japanese use these UDC (User defined charactors)? 
> I mean, for example, under Japanese version Windows 9x/NT/2000/XP, will the people use these UDC as Filename or others? 
> All these UDC have same value, or everyone has different UDC because it's called USER DEFINED?

Users define a character freely to those code points. e.g. the
character which isn't in SJIS etc.

So, probably those code was mapped to the Unicode's Private Use Area.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
