Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSBZWqu>; Tue, 26 Feb 2002 17:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSBZWqe>; Tue, 26 Feb 2002 17:46:34 -0500
Received: from jalon.able.es ([212.97.163.2]:11230 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S285692AbSBZWqO>;
	Tue, 26 Feb 2002 17:46:14 -0500
Date: Tue, 26 Feb 2002 23:46:05 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.18-rc4-jam2
Message-ID: <20020226234605.C6197@werewolf.able.es>
In-Reply-To: <20020225020725.A1674@werewolf.able.es> <20020226154814.GC4393@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020226154814.GC4393@matchmail.com>; from mfedyk@matchmail.com on mar, feb 26, 2002 at 16:48:14 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020226 Mike Fedyk wrote:
>On Mon, Feb 25, 2002 at 02:07:25AM +0100, J.A. Magallon wrote:
>> - 7* bproc
>
>What's this?

Beowulf Process Space (http://bproc.sourceforge.net/).
A kernel set of patches and modules to make a cluster look like
a single box wrt process management (SSI, single system image),
and allow efficient process migration between boxes. This is
just the part that patches the kernel.

Note this location is not an official one for BProc, but just my
hack to have the patch applying on recent development kernels,
and can be broken in some hidden way.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-jam1 #1 SMP Tue Feb 26 00:06:55 CET 2002 i686
