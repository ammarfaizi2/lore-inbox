Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWFJJuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWFJJuG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 05:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWFJJuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 05:50:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:2384 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751456AbWFJJuE (ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Sat, 10 Jun 2006 05:50:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=unzJpFeb/Wm19oMevRZ8iOy3G5fWyqFyID90gU4I+J6NLU3sEqzpE2YyDidYmwgW2G6gUGRDf+/Kd9MuRUEQPlyp7yKUCckN1jJHSTX8R8vGlBsXzAiR6a+UosFMG0zLkeHTD+Zox3Y+MaHtBoKEuKKxbKmZUJA87q4cLh80+2E=
Message-ID: <5486cca80606100250n4d30c756md66f04bf9b80bdac@mail.gmail.com>
Date: Sat, 10 Jun 2006 11:50:04 +0200
From: Antonio <tritemio@gmail.com>
To: markh@compro.net
Subject: Re: RT exec for exercising RT kernel capabilities
Cc: linux-kerneL@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>,
       "Steven Rostedt" <rostedt@goodmis.org>
In-Reply-To: <448876B9.9060906@compro.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <448876B9.9060906@compro.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/8/06, Mark Hounschell <markh@compro.net> wrote:
> With the ongoing work being done to rt kernel enhancements by Ingo and friends,
> I would like to offer the use of a user land test (rt-exec). The rt-exec tests
> well the deterministic real-time capabilities of a computer. Maybe it could
> useful in some way to the effort or to anyone interested in making this type of
> determination about their kernel/computer.
>
> A README describing the rt-exec can be found at
> ftp://ftp.compro.net/public/rt-exec/README

Sorry for the simple question. How do I check if my hardware support
HRT? Is it common on i386 desktops (mine is an Athlon XP 2000+)?

Many thanks.

Cheers,

  ~  Antonio
