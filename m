Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSKSNCI>; Tue, 19 Nov 2002 08:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbSKSNCI>; Tue, 19 Nov 2002 08:02:08 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:62182 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264672AbSKSNCG>;
	Tue, 19 Nov 2002 08:02:06 -0500
Date: Tue, 19 Nov 2002 13:07:28 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Margit Schubert-While <margit@margit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021119130728.GA28759@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 01:53:15PM +0100, Margit Schubert-While wrote:
 > 	Any chance to get an ACPI update into 2.4.20 ?

Now that we're in 2.4.20rc stage ? No chance.

 > 	It doesn't like my Intel D845PESV.
 
The newer ACPI code also introduces problems that aren't
present with the current 2.4.20rc code.
Eg: Last snapshot I tried, My Vaio wouldn't boot if it was
running on battery (which is the time I'd need it most).

It needs a lot more testing. 

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
