Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbSLDFVW>; Wed, 4 Dec 2002 00:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbSLDFVW>; Wed, 4 Dec 2002 00:21:22 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:10965 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S266917AbSLDFVW>; Wed, 4 Dec 2002 00:21:22 -0500
Date: Tue, 3 Dec 2002 21:24:03 -0800
From: Ben Fennema <bfennema@attbi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Erlend Aasland <erlend-a@ux.his.no>, bfennema@falcon.csc.calpoly.edu,
       dave@trylinux.com, linux_udf@hpesjro.fc.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (i386)
Message-ID: <20021203212403.B19780@attbi.com>
References: <20021203125120.GA2417@johanna5.ux.his.no> <20021203233744.AA03F2C29E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021203233744.AA03F2C29E@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Dec 04, 2002 at 10:37:04AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 10:37:04AM +1100, Rusty Russell wrote:
> In message <20021203125120.GA2417@johanna5.ux.his.no> you write:
> > I noticed that CONFIG_UDF_RW is not used anywhere, so I removed it from all
> > the defconfigs.
> 
> But it's used in 2.4.20.  It *looks* like it's on by default in 2.5,
> but I just want the authors to confirm that the option isn't coming
> back.
> 
> Ben, Dave?

Yup.. It's gone for good.

Ben
