Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbSLSBS2>; Wed, 18 Dec 2002 20:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbSLSBS2>; Wed, 18 Dec 2002 20:18:28 -0500
Received: from holomorphy.com ([66.224.33.161]:12735 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267474AbSLSBS1>;
	Wed, 18 Dec 2002 20:18:27 -0500
Date: Wed, 18 Dec 2002 17:24:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 15000+ processes -- poor performance ?!
Message-ID: <20021219012453.GJ31800@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Till Immanuel Patzschke <tip@inw.de>,
	lse-tech <lse-tech@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3E0116D6.35CA202A@inw.de> <3E011899.A3FBDAF1@inw.de> <20021219011541.GI31800@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021219011541.GI31800@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 04:53:45PM -0800, Till Immanuel Patzschke wrote:
>> forgot the kernel version (2.4.20aa1)...

On Wed, Dec 18, 2002 at 05:15:41PM -0800, William Lee Irwin III wrote:
> 2.4.20aa1 is missing some of the infrastructure to reduce the cpu
> consumption under high process count loads, but that's not going to
> help you anyway. 150K processes is not going to be feasible in the
> immediate future (months or longer away) so you'll have to figure out
> how to take that into account.

Er, sorry, on a brief rereading my eyes deceived me and I thought an
extra zero got in there. 15K is fine on 2.5 + patches.


Bill
