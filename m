Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264316AbTDKIJF (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 04:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTDKIJF (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 04:09:05 -0400
Received: from WARSL401PIP8.highway.telekom.at ([195.3.96.97]:33569 "HELO
	email01.aon.at") by vger.kernel.org with SMTP id S264316AbTDKIJD (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 04:09:03 -0400
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Subject: Re: rtl8139 Problem/kernel panic (probably unrelated)
Date: Fri, 11 Apr 2003 10:15:28 +0200
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304102118.24350.dusty@violin.dyndns.org> <3E95D488.60806@gmx.net>
In-Reply-To: <3E95D488.60806@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304111015.28708.dusty@violin.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 April 2003 22:31, Carl-Daniel Hailfinger wrote:
> Hermann Himmelbauer wrote:
> > Hi,
> > I have problems with my Ovis Link 10/100 PCI Network adapter (based on
> > RTL8139too)
> >
> > Until yesterday the NIC worked flawlessly with Linux-2.4.19-SuSE (from
> > SuSE 8.1) and rtl8139too (driver version 0.9.26).
>
> Have you tried upgrading your kernel to the current version from SuSE?
> The version number should be like k_deflt-2.4.19-274, which also would
> fix the ptrace problem.

Thank you for the reply. I upgradet my kernel to the new SuSE version. Till 
now the Kernel panic is gone, but the RTL8139 NIC problem has not changed.

Well - I think I'll have a look at a better quality card as the system gets 
unusable as my homedir is on NFS...

		Best Regards,
		Hermann

-- 
x1@aon.at
GPG key ID: 299893C7 (on keyservers)
FP: 0124 2584 8809 EF2A DBF9  4902 64B4 D16B 2998 93C7

