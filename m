Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSFPQet>; Sun, 16 Jun 2002 12:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSFPQes>; Sun, 16 Jun 2002 12:34:48 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:9894 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316309AbSFPQer>; Sun, 16 Jun 2002 12:34:47 -0400
Date: Sun, 16 Jun 2002 12:36:10 -0400
To: linux-kernel@vger.kernel.org
Cc: davej@suse.de, axboe@suse.de, akpm@zip.com.au
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020616163610.GA1731@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a stack trace with function names from the livelock 
during tiotest on 2.5.21 at:

http://home.earthlink.net/~rwhron/kernel/2.5.21.tasktrace

The task trace was create with:
http://home.earthlink.net/~rwhron/kernel/tasktrace

-- 
Randy Hron

