Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312459AbSDNVGe>; Sun, 14 Apr 2002 17:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312460AbSDNVGd>; Sun, 14 Apr 2002 17:06:33 -0400
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:25027 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S312459AbSDNVGd>;
	Sun, 14 Apr 2002 17:06:33 -0400
Message-ID: <3CB9EF57.6010609@tmsusa.com>
Date: Sun, 14 Apr 2002 14:06:31 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020414
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.8 final -
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Observations -

The up-fix for the setup_per_cpu_areas compile
issue apparently didn't make it into 2.5.8-final,
so we had to apply the patch from 2.5.8-pre3
to get it to compile.

That said, however, everything works, all services
are running, all devices working, Xfree is happy.

P4-B/1600,  genuine intel mobo running RH 7.2+rawhide

It also passes the q3a test with snappy results

:-)

Joe


