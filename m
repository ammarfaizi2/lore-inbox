Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318455AbSIFLZx>; Fri, 6 Sep 2002 07:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSIFLZw>; Fri, 6 Sep 2002 07:25:52 -0400
Received: from angband.namesys.com ([212.16.7.85]:34744 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318455AbSIFLZw>; Fri, 6 Sep 2002 07:25:52 -0400
Date: Fri, 6 Sep 2002 15:30:29 +0400
From: Oleg Drokin <green@namesys.com>
To: Jeff Chua <jchua@fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: remount reiserfs hangs under heavy load 2.4.20pre5
Message-ID: <20020906153029.A14514@namesys.com>
References: <Pine.LNX.4.42.0209052038310.31505-100000@silk.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.42.0209052038310.31505-100000@silk.corp.fedex.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Thank you for report.

On Thu, Sep 05, 2002 at 08:43:36PM +0800, Jeff Chua wrote:

> Whenever "mount -o remount -n -w /dev/hdax" is issued under disk
> activities, the system would freezed, and had to be hard booted.

What kind of disk activies?
What was mount status of filesystems before that command was it readonly
mounted ?

> Linux 2.4.20-pre5, but hangs too on 2.4.1x

I cannot reproduce this behavior with 2.4.19, can you please describe in more
details how can we reproduce?

Thank you.

Bye,
    Oleg
