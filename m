Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265281AbRFUXHW>; Thu, 21 Jun 2001 19:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265282AbRFUXHN>; Thu, 21 Jun 2001 19:07:13 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:30724 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265281AbRFUXG6>;
	Thu, 21 Jun 2001 19:06:58 -0400
Date: Thu, 21 Jun 2001 19:10:35 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Missing help entries in 2.4.6pre5
Message-ID: <20010621191035.A8796@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDEE1@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDEE1@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Thu, Jun 21, 2001 at 03:49:01PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew <andrew.grover@intel.com>:
> They're all in pre5 patch, around line 900.
> 
> Regards -- Andy

My error, thanks.  OK, the revised list of the missing is 

CONFIG_MOMENCO_OCELOT
CONFIG_MTD_CFI_VIRTUAL_ER

I'll release a 2.11 Configure.help shortly.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

An armed society is a polite society.  Manners are good when one 
may have to back up his acts with his life.
        -- Robert A. Heinlein, "Beyond This Horizon", 1942
