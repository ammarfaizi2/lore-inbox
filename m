Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSLPLIp>; Mon, 16 Dec 2002 06:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265143AbSLPLIp>; Mon, 16 Dec 2002 06:08:45 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:3332 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S264938AbSLPLIn>;
	Mon, 16 Dec 2002 06:08:43 -0500
To: linux-kernel@vger.kernel.org
Cc: Simon Oosthoek <simon@margo.student.utwente.nl>
Subject: Re: Q: i845MP/P4-M laptop support? (specific problems listed)
References: <20021216100610.GA16816@margo.student.utwente.nl>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20021216100610.GA16816@margo.student.utwente.nl>
Date: 16 Dec 2002 06:16:30 -0500
Message-ID: <m3d6o2gqnl.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Simon" == Simon Oosthoek <simon@margo.student.utwente.nl> writes:

Simon> - missing driver for smartmedia slot (I guess this is a feature
Simon> request, if it's not available) 

Simon> 02:06.0 System peripheral: Toshiba America Info Systems: Unknown device 0804

For the benefit of the archives, that is in the 2.5 kernel's pci.ids as:

        0804  TC6371AF SmartMedia Controller

Docs at:

http://www.toshiba.com/taec/components/Datasheet/TC6371AF--020122E_R1.8.pdf
http://216.239.53.100/search?q=cache:www.toshiba.com/taec/components/Datasheet/TC6371AF--020122E_R1.8.pdf

Also, a post archvied at:

http://linux.toshiba-dme.co.jp/ML/tlinux-users/1700/1739.html

suggests someone had the TC6371AF's smart media support working on a
suse 7.2 box back in 2002/January, FWIW.

-JimC

