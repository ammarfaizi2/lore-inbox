Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265210AbUELUHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUELUHD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUELUHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:07:02 -0400
Received: from main.gmane.org ([80.91.224.249]:36296 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265210AbUELUGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:06:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: 2.6.6 breaks VMware compile..
Date: Wed, 12 May 2004 22:06:52 +0200
Message-ID: <yw1xd659v28z.fsf@kth.se>
References: <407CF31D.8000101@rgadsdon2.giointernet.co.uk> <m365b15vls.fsf@ccs.covici.com>
 <20040512200322.GA4947@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:ATpHiUNa84P4trZ7PMFTGvQTXmA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez <linux-kernel@24x7linux.com> writes:

> On Wednesday, 12 May 2004, at 14:49:35 -0400,
> John Covici wrote:
>
>> How do Iget that patch since its still broke in 2.6.6?
>> 
> Maybe you forgot to "apply" the "patch" to VMware to allow it to compile
> its interface and run OK in newer kernels. Check:
> ftp://platan.vc.cvut.cz/pub/vmware
>
> for the latest version of the "patch" (vmware-any-any-update66.tar.gz).

I don't know if it's just me, but I had to build the modules manually.
The vmware-config.pl script didn't do the right thing.

-- 
Måns Rullgård
mru@kth.se

