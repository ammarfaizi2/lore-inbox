Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbTA0LAo>; Mon, 27 Jan 2003 06:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbTA0LAo>; Mon, 27 Jan 2003 06:00:44 -0500
Received: from [81.2.122.30] ([81.2.122.30]:5892 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267145AbTA0LAm>;
	Mon, 27 Jan 2003 06:00:42 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301271110.h0RBAPLq000352@darkstar.example.net>
Subject: Re: [RFC] Patches have a license
To: davej@codemonkey.org.uk (Dave Jones)
Date: Mon, 27 Jan 2003 11:10:25 +0000 (GMT)
Cc: balbir_soni@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030127104705.GC25913@codemonkey.org.uk> from "Dave Jones" at Jan 27, 2003 10:47:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > I would request everyone to post their patches with
>  > a license, failing which it should be assumed that
>  > the license is GPL.
> 
> Surely the license of the diff matches the license of the
> code it is patching ?  

That is what I've always thought.  However, in any case, even if the
patch itself isn't explicitly licensed as GPL, the code generated as a
result of patching a GPLed piece of code, must surely be GPLed,
because applying the patch is no different to editing the file with a
text editor.

John.
