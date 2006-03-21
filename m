Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWCUImo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWCUImo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 03:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWCUImo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 03:42:44 -0500
Received: from drugphish.ch ([69.55.226.176]:13800 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S965016AbWCUImn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 03:42:43 -0500
Message-ID: <441FBCCF.1030303@drugphish.ch>
Date: Tue, 21 Mar 2006 09:43:59 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Idea to create a elf executable from running program [process2executable]
References: <3faf05680603181422y7447fd7duc1032bd0e07b9c68@mail.gmail.com>
In-Reply-To: <3faf05680603181422y7447fd7duc1032bd0e07b9c68@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been working on an idea of creating an executable from a
> running process image.

This has been done before.

> [PS: I dont know if some one has already implemented this idea??]

This may suit your needs:

http://www.phrack.org/phrack/63/p63-0x0c_Process_Dump_and_Binary_Reconstruction.txt

IIRC, Silvio Cesare was the first one a couple of years ago that wrote a 
proof of concept tool which dumped the memory space of a process to an 
ELF executable, somewhere around 1999:

http://www.transient-iss.com/pit/elf.txt

Best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
