Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSKZWjM>; Tue, 26 Nov 2002 17:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSKZWjM>; Tue, 26 Nov 2002 17:39:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1540 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261356AbSKZWjK>; Tue, 26 Nov 2002 17:39:10 -0500
Message-ID: <3DE3F9AC.4040107@zytor.com>
Date: Tue, 26 Nov 2002 14:46:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: RAID-6 development snapshot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because some people asked, I dropped a development snapshot of the 
RAID-6 code at:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/raid6-20021126-dontuse.tar.gz

THIS IS NOT A WORKING RAID-6 IMPLEMENTATION.  It's my current 
development snapshot, and attempting to use it *will* result in crashes 
and kernel panics.

It does, however, contain a RAID-6 algorithm test and benchmark program 
that should work.

	-hpa

