Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268099AbTBRXa7>; Tue, 18 Feb 2003 18:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268100AbTBRXa7>; Tue, 18 Feb 2003 18:30:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:35734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268099AbTBRXa4>;
	Tue, 18 Feb 2003 18:30:56 -0500
Subject: Re: [Fastboot] [KEXEC][2.5.61][2.5.62] Untested patches available
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <1045589128.23988.34.camel@andyp.pdx.osdl.net>
References: <1044918007.1705.22.camel@andyp.pdx.osdl.net>
	 <1045589128.23988.34.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1045615235.1118.5.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Feb 2003 16:40:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 09:25, Andy Pfiffer wrote:
> Eric,
> 
> I have carried forward the kexec patch set to 2.5.61 and 2.5.62.
> Other than basic compile testing, I have not yet finished kicking the
> tires on these patches.

FYI: the 2.5.62 patch set (see below) works for me on my x86 uniproc and
on my 2-way x86 system.

I did not need to edit/modify kexec-tools-1.8 for it to work on either
of my systems.  (my copy of kexec-tools-1.8 is available here:
http://www.osdl.org/archive/andyp/kexec/ ).

Regards,
Andy


> The patches are available for download from OSDL's patch lifecycle
> manager (PLM):
> 
> Patch Stack for 2.5.62:
> 
> 	kexec base for 2.5.62 (based upon the version for 2.5.54):
> 	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1560
> 
> 	kexec hwfixes for 2.5.62 (based upon the version for 2.5.5[89])
> 	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1561
> 
> 	kexec usemm change (allowed 2-way to work for me):
> 	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1562
> 
> 	optional change to defconfig (I used this for PLM-based builds)
> 	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1564



