Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbUB0MuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbUB0MuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:50:00 -0500
Received: from main.gmane.org ([80.91.224.249]:17554 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262761AbUB0Mt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:49:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Gentoo mm-sources-2.6.3 kenrel's problem
Date: Fri, 27 Feb 2004 13:49:55 +0100
Message-ID: <yw1xishsy9e4.fsf@kth.se>
References: <20040227124205.84877.qmail@span.corp.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:VuEF8xEaBMmxJGtZue+UzMoUYXc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

duoduo <kfduoduo@yahoo.com> writes:

>  when i issue sync command immediately after deleting
> a large file or directory, the whole system will
> freeze
> with no reaction, only could do rebooting

What filesystem?  What type of disk?  Does the machine respond to
network?  Is the error easily reproducible?  Try it at a text console
and see if there's a panic message.

-- 
Måns Rullgård
mru@kth.se

