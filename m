Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUBHELQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 23:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUBHELQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 23:11:16 -0500
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.68]:62012 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262078AbUBHELP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 23:11:15 -0500
Date: Sat, 07 Feb 2004 23:12:36 -0500
From: Robert F Merrill <griever@t2n.org>
Subject: Re: 2.6.2-mm1 seems to break ALSA and DRI module compilation
In-reply-to: <40258EE2.9000507@t2n.org>
To: linux-kernel@vger.kernel.org
Message-id: <4025B734.8080102@t2n.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
 Debian/1.6-1
References: <40258EE2.9000507@t2n.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert F Merrill wrote:

> Just got 2.6.2-mm1 running... however I get a bunch of module errors
> when I try to load my (seperately compiled) ALSA and DRI modules
>
> first of all, nearly every alsa module complains about a billion 
> undefined symbols
> secondly, I get the error "module falsely claims to have symbol ^A".
>
>
*snip*

> I'm going to go to vanilla 2.6.2 and see if that has the problem.
>
It doesn't, seems to be a -mm1 specific bug.

