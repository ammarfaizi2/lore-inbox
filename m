Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287630AbSALXOc>; Sat, 12 Jan 2002 18:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287633AbSALXOY>; Sat, 12 Jan 2002 18:14:24 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:23253 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287630AbSALXOO>; Sat, 12 Jan 2002 18:14:14 -0500
Date: Sat, 12 Jan 2002 18:14:12 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andreas Haumer <andreas@xss.co.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.2.20 SMP & Asus CUR-DLS: "stuck on TLB IPI wait (CPU#3)"
Message-ID: <20020112181412.B31913@redhat.com>
In-Reply-To: <3C40B268.C2B87902@xss.co.at> <20020112173430.A31913@redhat.com> <3C40C066.CF147D02@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C40C066.CF147D02@xss.co.at>; from andreas@xss.co.at on Sun, Jan 13, 2002 at 12:01:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 12:01:58AM +0100, Andreas Haumer wrote:
> Aha!
> 
> Anyone working on backporting it to 2.2.21? 
> Alan?

That's unlikely: the improvements in smp locking are what 2.4 was all about, 
so "backporting" them is basically reinventing 2.4.

		-ben
