Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSGVLb0>; Mon, 22 Jul 2002 07:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSGVLb0>; Mon, 22 Jul 2002 07:31:26 -0400
Received: from ns.suse.de ([213.95.15.193]:61968 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316788AbSGVLbZ>;
	Mon, 22 Jul 2002 07:31:25 -0400
Date: Mon, 22 Jul 2002 13:34:32 +0200
From: Dave Jones <davej@suse.de>
To: Karol Olechowskii <karol_olechowski@acn.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon XP 1800+ segemntation fault
Message-ID: <20020722133432.N27749@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Karol Olechowskii <karol_olechowski@acn.waw.pl>,
	linux-kernel@vger.kernel.org
References: <20020722133259.A1226@acc69-67.acn.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020722133259.A1226@acc69-67.acn.pl>; from karol_olechowski@acn.waw.pl on Mon, Jul 22, 2002 at 01:32:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 01:32:59PM +0000, Karol Olechowskii wrote:
 > Hello 
 > 
 > Few days ago I've bought new processor Athlon XP 1800+ to my computer
 > (MSI K7D Master with 256 MB PC2100 DDR).Before that I've got Athlon ThunderBird
 > 900 processor and everything had been working well till I change to the new one.
 > Now for every few minutes I've got segmetation fault or immediate system reboot.
 > Could anyone tell me what's goin' on?
 > ...
 > Jul 21 11:26:01 alpha kernel: EIP:    0010:[<c01a2942>]    Tainted: P
                                                              ^^^^^^^^^^^
 > nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
 > devfs_register(nvidiactl): could not append to parent, err: -17
 > devfs_register(nvidia0): could not append to parent, err: -17


Ask nvidia. Only they can help you. They have the kernel source,
we don't have their source.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
