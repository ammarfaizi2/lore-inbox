Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSHBU2g>; Fri, 2 Aug 2002 16:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSHBU2g>; Fri, 2 Aug 2002 16:28:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16865 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316857AbSHBU2f>;
	Fri, 2 Aug 2002 16:28:35 -0400
Date: Fri, 02 Aug 2002 15:31:53 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30] Allow tasks to share credentials
Message-ID: <98040000.1028320313@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0208021309200.2466-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0208021309200.2466-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, August 02, 2002 01:10:48 PM -0700 Linus Torvalds
<torvalds@transmeta.com> wrote:

> This still has the "security hole you can run a slow-moving bight yellow
> truck with flashing lights on through" problem..

My apologies. I've been trying to get a copy of the patch that lkml would
accept, and had not seen your reply when I sent that one out.  I'll rework
the patch and resubmit.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

