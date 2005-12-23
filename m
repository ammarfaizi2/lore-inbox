Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030569AbVLWQ3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbVLWQ3u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 11:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbVLWQ3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 11:29:50 -0500
Received: from student.if.pw.edu.pl ([194.29.174.5]:53203 "EHLO
	tleilax.if.pw.edu.pl") by vger.kernel.org with ESMTP
	id S1030569AbVLWQ3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 11:29:49 -0500
Date: Fri, 23 Dec 2005 17:29:44 +0100 (CET)
From: Marek Szuba <cyberman@if.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Requests for 2.4.33 (ip6t_REJECT, quota_v2)
Message-ID: <Pine.LNX.4.62.0512231719020.19723@gyrvynk.vs.cj.rqh.cy>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="499254702-533768847-1135355384=:19723"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--499254702-533768847-1135355384=:19723
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello,

Sorry in advance if this has already been asked. Anyway:

1. Would it be possible for the IPv6 REJECT netfilter module to be 
backported to 2.4?

2. Apparently the quota_v2 module in 2.4 still lacks the licence macro 
and taints the kernel, even though the same module in 2.6 is correctly 
tagged as GPL. Any chance of seeing this corrected? In case it makes 
things any easier, I am enclosing an appropriate patch.

Merry Christmas, everyone!
-- 
MS
--499254702-533768847-1135355384=:19723
Content-Type: APPLICATION/octet-stream; name=quota_v2.c-modtags.diff.bz2
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0512231729440.19723@gyrvynk.vs.cj.rqh.cy>
Content-Description: 
Content-Disposition: attachment; filename=quota_v2.c-modtags.diff.bz2

QlpoOTFBWSZTWbom08UAACPfgAIwWH//nW7//wC/Z/8gMADs2oaVP1TATag0
DTEAAaaAZB5ENBCnopjaCQAAAAAAaZANBKmiTRkYjQAA0NAAAaABXHQRQoiN
uFkzI3CFDggafEoZSd5HeWJHyNY3yeLVz4QE05OEWpFRD4vANPmGis91/EMj
QxsMctYsQjGEAwjQgGI8fZghlxEoWqR0bHBbqDCgQpkVZeO5ELq7bfWWRMiO
4ly55RxQvoI0sXKK7gq35pBz0I1KjSTTOis0qa8SWnGiwnVtSbhDGsYpTiUo
SM0z8Q6leYOiZVmegMUmLdQ4VPG0GhOYFMg7A6L4JvuYMxE5oQwPTCtQIBMR
MswCxdv8FY74Qw2LrH8XckU4UJC6JtPF

--499254702-533768847-1135355384=:19723--
