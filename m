Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267881AbTAMOC7>; Mon, 13 Jan 2003 09:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267909AbTAMOC7>; Mon, 13 Jan 2003 09:02:59 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:27533 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267881AbTAMOC7>;
	Mon, 13 Jan 2003 09:02:59 -0500
Date: Mon, 13 Jan 2003 14:08:55 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Vadlapudi Madhu <Vadlapudi.Madhu@cse.iitkgp.dhs.org>
Cc: linux-kernel@vger.kernel.org,
       "Vadlapudi.Madhu - 01cs6020" <vmadhu@cse.iitkgp.dhs.org>
Subject: Re: Is linux kernel is available for any AMD processors?
Message-ID: <20030113140855.GH9031@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Vadlapudi Madhu <Vadlapudi.Madhu@cse.iitkgp.dhs.org>,
	linux-kernel@vger.kernel.org,
	"Vadlapudi.Madhu - 01cs6020" <vmadhu@cse.iitkgp.dhs.org>
References: <Pine.LNX.4.33L2.0301131922180.4477-100000@cpusrv-ibm-5.cse.iitkgp.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301131922180.4477-100000@cpusrv-ibm-5.cse.iitkgp.ernet.in>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 07:26:43PM +0530, Vadlapudi Madhu wrote:

 > Just i want to know, whether linux kernel is available any of the AMD's
 > processors. If yes, please direct towards a web page where i can get some
 > more information.

All of AMD's CPUs should work fine with the standard kernel.
They'll boot a generic 'i386' kernel, or you can compile
specific kernels optimised for Athlon/Duron.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
