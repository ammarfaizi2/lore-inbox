Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263728AbUELUfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbUELUfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUELUfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:35:34 -0400
Received: from main.gmane.org ([80.91.224.249]:3529 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263728AbUELUfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:35:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: 2.6.6 breaks VMware compile..
Date: Wed, 12 May 2004 22:35:24 +0200
Message-ID: <yw1x65b1v0xf.fsf@kth.se>
References: <407CF31D.8000101@rgadsdon2.giointernet.co.uk> <m365b15vls.fsf@ccs.covici.com>
 <20040512200322.GA4947@localhost> <yw1xd659v28z.fsf@kth.se>
 <20040512202039.GB4947@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:825jccrLZgEncwAoeUqAeF/0tAQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez <linux-kernel@24x7linux.com> writes:

> On Wednesday, 12 May 2004, at 22:06:52 +0200,
> Måns Rullgård wrote:
>
>> I don't know if it's just me, but I had to build the modules manually.
>> The vmware-config.pl script didn't do the right thing.
>> 
> I just untarred the mentioned tarball, run the "runme.pl" script, and
> then everything compiled and loaded into memory just fine.

When I did that it built something the kernel told me wasn't a module
at all.

-- 
Måns Rullgård
mru@kth.se

