Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286332AbRLTTE7>; Thu, 20 Dec 2001 14:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbRLTTEu>; Thu, 20 Dec 2001 14:04:50 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:54153
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286327AbRLTTEg>; Thu, 20 Dec 2001 14:04:36 -0500
Date: Thu, 20 Dec 2001 13:52:13 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Steven Cole <scole@lanl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Message-ID: <20011220135213.B18128@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Steven Cole <scole@lanl.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <200112201721.KAA05522@tstac.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112201721.KAA05522@tstac.esa.lanl.gov>; from scole@lanl.gov on Thu, Dec 20, 2001 at 11:02:28AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <scole@lanl.gov>:
> I see that in the very latest Configure.help version, 2.76,
> available at http://www.tuxedo.org/~esr/cml2/ Eric has decided to
> follow the following standard: IEC 60027-2, Second edition, 2000-11,
> Letter symbols to be used in electrical technology - Part 2:
> Telecommunications and electronics.  and has changed all the
> abbreviations for Kilobyte (KB) to KiB, Megabyte (MB) to MiB, etc,
> etc.

This change came as a patch from David Woodhouse.  I think the new
abbreviations are awful ugly, myself, but they do have the virtue of
not being ambiguous.  So I swallowed hard and took the patch.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The right to buy weapons is the right to be free.
        -- A.E. Van Vogt, "The Weapon Shops Of Isher", ASF December 1942
