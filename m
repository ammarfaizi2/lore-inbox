Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268495AbTANBue>; Mon, 13 Jan 2003 20:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268496AbTANBue>; Mon, 13 Jan 2003 20:50:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24626 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268495AbTANBu3>; Mon, 13 Jan 2003 20:50:29 -0500
To: "Fu, Michael" <michael.fu@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] kexec-tools-1.8
References: <957BD1C2BF3CD411B6C500A0C944CA2602CB5E31@pdsmsx32.pd.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2003 18:57:50 -0700
In-Reply-To: <957BD1C2BF3CD411B6C500A0C944CA2602CB5E31@pdsmsx32.pd.intel.com>
Message-ID: <m1n0m4fq75.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Fu, Michael" <michael.fu@intel.com> writes:

> On 2002-12-02 at 04:41:34, Eric wrote:
> >kexec-tools-1.8 is now available at :
> >http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.8.tar.gz
> 
> I can't use the kexec program in the package to load a bzImage file. The
> following simple patch make it work.

Thanks.  I rarely force the type, so it looks like this bug slipped by.


Eric
