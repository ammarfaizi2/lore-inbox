Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269133AbTBZVlR>; Wed, 26 Feb 2003 16:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269182AbTBZVlR>; Wed, 26 Feb 2003 16:41:17 -0500
Received: from gaea.projecticarus.com ([195.10.228.71]:63371 "EHLO
	gaea.projecticarus.com") by vger.kernel.org with ESMTP
	id <S269133AbTBZVlP>; Wed, 26 Feb 2003 16:41:15 -0500
Message-ID: <3E5D36D4.7030306@walrond.org>
Date: Wed, 26 Feb 2003 21:51:16 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo shows only 2 processors on dual P4-Xeon system
References: <F760B14C9561B941B89469F59BA3A8471380CF@orsmsx401.jf.intel.com> <3E5D096F.9020308@walrond.org> <200302261244.46635.habanero@us.ibm.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Theurer wrote:
> Does your system BIOS have an option to enable/disable HT support?  If it 
> does, make sure it is enabled.
> 
> I would have expected to see 4 ioapics, but hmm, I don't really know.
> 

All the obvious stuff like bios is correct :)
The 2.4 kernel works fine; 4 cpus detected and displayed in /proc/cpuinfo.
2.5 has never worked properly yet with this m/b; A shame since it's asus 
  top of the range dual xeon server board, the PR-DLS.

The 3 io-apics are indeed strange. I'm hoping Andrew Grover might have 
some ideas...?

Andrew Walrond

