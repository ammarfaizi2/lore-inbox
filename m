Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318356AbSIKFne>; Wed, 11 Sep 2002 01:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318376AbSIKFne>; Wed, 11 Sep 2002 01:43:34 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:25220 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318356AbSIKFne>; Wed, 11 Sep 2002 01:43:34 -0400
Date: Wed, 11 Sep 2002 01:51:03 -0400
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: ltp directio test causes oops on 2.4.20pre5aa2
Message-ID: <20020911055103.GA4982@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the meantime you
> can test with this incremental fix:

I've ran ltp on reiserfs and ext3 and 2.4.19pre5aa2 
passes the ltp directio tests with no oops.  The new 
nanosleep tests in ltp-20020910 pass too.

Thanks!
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

