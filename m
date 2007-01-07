Return-Path: <linux-kernel-owner+w=401wt.eu-S964967AbXAGT3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbXAGT3B (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbXAGT3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:29:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:35719 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964967AbXAGT3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:29:00 -0500
In-Reply-To: <20070107111900.9d434162.randy.dunlap@oracle.com>
References: <20070106221947.8e01d404.randy.dunlap@oracle.com> <33e707f92df6b89a1c22f337f230cf32@kernel.crashing.org> <20070107104555.015aa79f.randy.dunlap@oracle.com> <974f8eb0d5984af6726a130082453916@kernel.crashing.org> <20070107111900.9d434162.randy.dunlap@oracle.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <79c1e7a7bfa499fc896c00a1adb0edeb@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] math-emu/setcc: avoid gcc extension
Date: Sun, 7 Jan 2007 20:29:21 +0100
To: Randy Dunlap <randy.dunlap@oracle.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There's an extra tab in that last line.  Could you also
>> please fix the indenting (use a tab, not spaces) -- I know
>> it was there originally, but since there are only a few
>> lines in that file like that...  :-)
>
> how's this one?

I meant fix all the wrongly indented lines in that file (there
are only a few, and all around where you're patching anyway).

Care for one extra time?  :-)


Segher

