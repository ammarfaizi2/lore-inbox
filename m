Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319111AbSHMVTA>; Tue, 13 Aug 2002 17:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319115AbSHMVTA>; Tue, 13 Aug 2002 17:19:00 -0400
Received: from ns.suse.de ([213.95.15.193]:3342 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319111AbSHMVTA>;
	Tue, 13 Aug 2002 17:19:00 -0400
Date: Tue, 13 Aug 2002 23:22:51 +0200
From: Dave Jones <davej@suse.de>
To: =?iso-8859-1?Q?Pau_Montero_Par=E9s?= <pau@imente.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP Athlon troubles under high load
Message-ID: <20020813232251.P13598@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	=?iso-8859-1?Q?Pau_Montero_Par=E9s?= <pau@imente.com>,
	linux-kernel@vger.kernel.org
References: <3D5919A8.1080908@imente.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D5919A8.1080908@imente.com>; from pau@imente.com on Tue, Aug 13, 2002 at 04:37:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 04:37:28PM +0200, Pau Montero Parés wrote:
 > processor       : 0
 > vendor_id       : AuthenticAMD
 > cpu family      : 6
 > model           : 4
 > model name      : AMD Athlon(tm) Processor
 > stepping        : 4

According to my notes, 644 isn't a valid CPU for reliable MP operation.
The earliest Athlon rated 'smp safe' is model 6 stepping 0.
Anyone with anything earlier that isn't having problems is
getting 'lucky'.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
