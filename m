Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132838AbRDUTWP>; Sat, 21 Apr 2001 15:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132843AbRDUTWF>; Sat, 21 Apr 2001 15:22:05 -0400
Received: from port29.ds1-rdo.adsl.cybercity.dk ([212.242.196.94]:43121 "HELO
	xyzzy.adsl.dk") by vger.kernel.org with SMTP id <S132838AbRDUTVv>;
	Sat, 21 Apr 2001 15:21:51 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Idea: Encryption plugin architecture for file-systems
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com>
X-Home-Page: http://peter.makholm.net/
Xyzzy: Nothing happens!
From: Peter Makholm <peter@makholm.net>
Date: 21 Apr 2001 21:21:44 +0200
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com> (nagytam@rerecognition.com's message of "Sat, 21 Apr 2001 18:56:42 +0000 (UTC)")
Message-ID: <8766fyt5x3.fsf@xyzzy.adsl.dk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nagytam@rerecognition.com ("Tamas Nagy") writes:

> Idea:
> extend the current file-system with an optional plug-in system, which allows
> for file-system level encryption instead of file-level.

That's is one of the things the loop device offers. For better
encryption than XOR you need the patches from kerneli.org.

(Remember the problems whith crypto code in the US is mainly with
exporting it neither importing or using it.)

-- 
hash-bang-slash-bin-slash-bash
