Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277151AbRJDHJ7>; Thu, 4 Oct 2001 03:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277149AbRJDHJr>; Thu, 4 Oct 2001 03:09:47 -0400
Received: from zok.sgi.com ([204.94.215.101]:39596 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277147AbRJDHJd>;
	Thu, 4 Oct 2001 03:09:33 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - gameport_{,un}register_port must be static when inline 
In-Reply-To: Your message of "Thu, 04 Oct 2001 15:04:39 +1000."
             <15291.60903.127755.574686@notabene.cse.unsw.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Oct 2001 15:10:31 +1000
Message-ID: <11465.1002172231@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001 15:04:39 +1000 (EST), 
Neil Brown <neilb@cse.unsw.edu.au> wrote:
>Are you sure?  2.4.10 seems to have a big input rewrite, and
>patch-2.4.10-ac4 doesn't change gameport.h and makes only minimal
>changes to esssolo1.c, one of the drivers in question.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99419452230792&w=2, find
gameport.  It was finally fixed in 2.4.5-ac17.

