Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287609AbSALWe5>; Sat, 12 Jan 2002 17:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287617AbSALWer>; Sat, 12 Jan 2002 17:34:47 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:40141 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287609AbSALWeb>; Sat, 12 Jan 2002 17:34:31 -0500
Date: Sat, 12 Jan 2002 17:34:30 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andreas Haumer <andreas@xss.co.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.2.20 SMP & Asus CUR-DLS: "stuck on TLB IPI wait (CPU#3)"
Message-ID: <20020112173430.A31913@redhat.com>
In-Reply-To: <3C40B268.C2B87902@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C40B268.C2B87902@xss.co.at>; from andreas@xss.co.at on Sat, Jan 12, 2002 at 11:02:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 11:02:16PM +0100, Andreas Haumer wrote:
> Hi!
> 
> I'm seeing a problem with SMP Linux-2.2.20 on an ASUS CUR-DLS
> motherboard. I noticed there were similar reports in the
> past few months and I got the impression the problem should
> already be fixed in 2.2.20, but seemingly it isn't.

This bug is fixed in 2.4.

		-ben
