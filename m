Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135769AbRDTBGW>; Thu, 19 Apr 2001 21:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135770AbRDTBGL>; Thu, 19 Apr 2001 21:06:11 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:28310 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135769AbRDTBFv>;
	Thu, 19 Apr 2001 21:05:51 -0400
To: Jens Axboe <axboe@suse.de>
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        linux-openlvm@nl.linux.org
Subject: Re: [linux-lvm] 2.4.3-ac{6,7} LVM hang
In-Reply-To: <Pine.LNX.4.21.0104161653140.14442-100000@imladris.rielhome.conectiva>
	<Pine.LNX.4.31.0104192311080.1048-100000@sjoerd.sjoerdnet>
	<20010419235107.G750@suse.de>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 19 Apr 2001 18:05:03 -0700
In-Reply-To: Jens Axboe's message of "Thu, 19 Apr 2001 23:51:07 +0200"
Message-ID: <m3n19cxtxc.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> Does attached patch fix it?

Yes.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
