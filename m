Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268224AbUHYSeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268224AbUHYSeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268250AbUHYScl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:32:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268224AbUHYSb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:31:26 -0400
Date: Wed, 25 Aug 2004 14:31:20 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
In-Reply-To: <024c01c48a89$283dd4f0$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0408251430340.26239-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004, Kaigai Kohei wrote:

> By the way, the results of dbench are sharply changed at every measurement.
> I don't think it is statistically-significant.

Try running dbench on an ext2 filesystem (including both the 'client' 
file and where you run it locally).


- James
-- 
James Morris
<jmorris@redhat.com>


