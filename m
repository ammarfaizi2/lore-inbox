Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbWJXOFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWJXOFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWJXOFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:05:01 -0400
Received: from ns2.suse.de ([195.135.220.15]:63448 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161092AbWJXOFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:05:00 -0400
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [RFC][PATCH 0/11] i386: Relocatable BzImage (V3)
Date: Tue, 24 Oct 2006 06:44:20 -0700
User-Agent: KMail/1.9.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com>
In-Reply-To: <20061023192456.GA13263@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610240644.20940.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 12:24, Vivek Goyal wrote:
> Hi,
>
> Here is the third attempt on implementing relocatable bzImage for i386.
> Eric has done all the ground work and I am just giving it final finish.
> Generated patches against (2.6.19-rc2-git7).

I merged them now. Didn't see anything that i didn't like, but I admit
i haven't read everything closely

-Andi
