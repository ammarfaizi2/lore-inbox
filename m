Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266730AbUF3PkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266730AbUF3PkC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266700AbUF3Ph3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:37:29 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:14098 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266730AbUF3Pf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:35:29 -0400
Message-ID: <40E2E2A3.4000101@techsource.com>
Date: Wed, 30 Jun 2004 11:56:19 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Experimental PS/2 driver with heuristic synchronization
References: <20040630123839.GA1333@ucw.cz>
In-Reply-To: <20040630123839.GA1333@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Vojtech Pavlik wrote:
> Hi!
> 
> I wanted to try if my thoughts about how to reliably synchronize the
> PS/2 mouse stream would work, and as a test I created this driver.
> 


This is an awesome idea.  I've always had intermittent problems with 
mice freaking out under Linux.  Most of the time, it only freaks out for 
a few seconds, but sometimes, I have to ctrl-alt-F1+ctrl-alt-F7 to get 
the mouse back.

A patck like yours has been needed for a long time.  Good show!

