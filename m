Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbTAJSt7>; Fri, 10 Jan 2003 13:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTAJSsy>; Fri, 10 Jan 2003 13:48:54 -0500
Received: from mail.set-software.de ([193.218.212.121]:25302 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP
	id <S266228AbTAJSsf> convert rfc822-to-8bit; Fri, 10 Jan 2003 13:48:35 -0500
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Fri, 10 Jan 2003 18:56:52 GMT
Message-ID: <20030110.18565214@knigge.local.net>
Subject: Stupid SMBUS question...
To: <linux-kernel@vger.kernel.org>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on a tool that can display information of a computer's 
hardware. For this I want to parse the SMBIOS-Structure. I know that I 
could search /proc/kcore for the "_SM_" eyecatcher, but I wonder if 
there is a "easier" way to get the information (so the tool don't have 
to run setuid-root).

Is there a way? 


Thank you in advance and have a nice weekend,
  Michael




