Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266727AbUGVQuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266727AbUGVQuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUGVQuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:50:23 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:14273 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266727AbUGVQuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:50:22 -0400
Message-ID: <40FFE056.8050804@kegel.com>
Date: Thu, 22 Jul 2004 08:42:14 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaos@sgi.com
Subject: re: Announce: dumpfs v0.01 - common RAS output API
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos () sgi ! com> wrote:
> Announcing dumpfs - a common API for all the RAS code that wants to
> save data during a kernel failure and to extract that RAS data on the
> next boot.  The documentation file is appended to this mail.
 > ...

I looked, but couldn't see any definition for RAS in your doc.
Could you add one?
The fs/Kconfig hunk might be a nice place to define it, since
naive users might see that text when configuring kernels.

http://www.kernelnewbies.org/glossary/#R does define it,
but it's so far down on
http://www.google.com/search?q=define%3Aras
that most people configuring a kernel might not be familiar with that sense.
- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
