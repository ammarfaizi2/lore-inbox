Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288759AbSAIVAg>; Wed, 9 Jan 2002 16:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSAIVA3>; Wed, 9 Jan 2002 16:00:29 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:50368 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S288759AbSAIVAQ>; Wed, 9 Jan 2002 16:00:16 -0500
Message-ID: <3C3CAEDD.8040707@bigpond.net.au>
Date: Thu, 10 Jan 2002 04:58:05 +0800
From: peter <arevill@bigpond.net.au>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Steps to open a file/handled by kernel?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC: all replies to: arevill@bigpond.net.au
Hi guys, im in discussion with one of my compsci mates to start an 
intresting little project, its not concrete yet, not at all, i really 
need to get a good grasp of what im going to have to code before i 
decide to jump in or not, ill give you a quick run down

Basically we want to make a sort of.. auto compression/uncompression of 
files as there accessed/not accessed, basically to save a hell of alot 
of space, but before we even BEGIN to do it, i really need to understand 
the calls and the "arguments" and the stages the kernel/userspace (if it 
is invovled (if userspace is even the right word!) takes to read from a 
file (and write to it while we are at it)

any information people feel is relevant or any sort of url u can point 
me to or just a little guide of waht happens would be appreciiated, 
please CC: all msgs to arevill@bigpond.net.au

Cheers
:)
Peter



