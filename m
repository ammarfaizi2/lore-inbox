Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWIOHaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWIOHaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 03:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWIOHaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 03:30:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:9193 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751124AbWIOHaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 03:30:03 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <450A5607.604@s5r6.in-berlin.de>
Date: Fri, 15 Sep 2006 09:28:07 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: R: Linux kernel source archive vulnerable
References: <20060907182304.GA10686@danisch.de> <B7C6636B-03E9-4D4C-AC0E-2898181F419B@mac.com> <ee8a8j$gf7$1@taverner.cs.berkeley.edu> <45F1F6C1-FB19-4E6D-BEFE-B8C541D7A2F3@mac.com> <eeclke$s44$1@taverner.cs.berkeley.edu>
In-Reply-To: <eeclke$s44$1@taverner.cs.berkeley.edu>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
> Keep in mind that there are good reasons to extract the Linux tarball
> as root.  There is a long-standing tradition of storing the kernel
> source under /usr/src, and usually /usr/src is writeable only by root.

This no "good reason" to extract the tarball as root.

(Anyway, the discussion about running tar as root is besides the point.)
-- 
Stefan Richter
-=====-=-==- =--= -====
http://arcgraph.de/sr/
