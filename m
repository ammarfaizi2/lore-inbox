Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269457AbRHGVRu>; Tue, 7 Aug 2001 17:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269462AbRHGVRk>; Tue, 7 Aug 2001 17:17:40 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:59783 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S269457AbRHGVRc>; Tue, 7 Aug 2001 17:17:32 -0400
Message-ID: <3B704C86.5010401@earthlink.net>
Date: Tue, 07 Aug 2001 16:16:06 -0400
From: Brad Chapman <kakadu@earthlink.net>
Reply-To: kakadu@adelphia.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.7 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange compilation messages with gcc 2.96.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   When I compile the 2.4.7 kernel on a RedHat system with an Athlon 
1GHz processor
and gcc 2.96.2, I get a LOT of messages similar to the following:

   <source file>:<number>:<number>: pasting would not give a valid 
preprocessor token

   They don't seem to be a problem; they're annoying, but they don't 
prevent the compilation
of the kernel. Is this a problem? Or is it just another compile-time 
annoyance?

Thanks,

Brad

