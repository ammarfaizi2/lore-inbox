Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316069AbSETPAU>; Mon, 20 May 2002 11:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSETPAT>; Mon, 20 May 2002 11:00:19 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:19697 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316069AbSETPAS>; Mon, 20 May 2002 11:00:18 -0400
Date: Mon, 20 May 2002 11:00:18 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Neil Aggarwal <neil@JAMMConsulting.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug in RedHat 7.3 -- Assertion failure in journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"
Message-ID: <20020520110018.C31507@redhat.com>
In-Reply-To: <ENEBKGGOKDOEALIKAJMBOEIPCGAA.neil@JAMMConsulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 04:18:25PM -0500, Neil Aggarwal wrote:
> Has anyone seen this?  Is there a way to fix it?

The 2.4.19-4 kernel was released to fix exactly this problem, iirc.

		-ben
