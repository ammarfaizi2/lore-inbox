Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSK0Up2>; Wed, 27 Nov 2002 15:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264795AbSK0Up2>; Wed, 27 Nov 2002 15:45:28 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:46089 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S264790AbSK0Up1>; Wed, 27 Nov 2002 15:45:27 -0500
Message-ID: <3DE52FC7.1050405@ixiacom.com>
Date: Wed, 27 Nov 2002 12:49:11 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: re: epoll patches queue status and glibc submission ...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davide,
I just realized that 'edge triggered I/O readiness notification facility'
is too jargony.  A plain English wording of the man page title might be

epoll \- I/O readiness change notification facility

This is shorter and much clearer.  Apologies for having suggested
the earlier jargony text.
- Dan

