Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131254AbRC3J13>; Fri, 30 Mar 2001 04:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131269AbRC3J1T>; Fri, 30 Mar 2001 04:27:19 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:46344 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131254AbRC3J1P>; Fri, 30 Mar 2001 04:27:15 -0500
Date: Thu, 29 Mar 2001 13:57:17 +0200
From: Jens Taprogge <taprogge@idg.rwth-aachen.de>
To: Klaus Reimer <k@ailis.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 in 2.4.2 on Toshiba Tecra 8000
Message-ID: <20010329135717.A1466@maggie.romantica.wg>
Mail-Followup-To: Jens Taprogge <taprogge@idg.rwth-aachen.de>,
	Klaus Reimer <k@ailis.de>, linux-kernel@vger.kernel.org
In-Reply-To: <01032910124007.00454@neo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <01032910124007.00454@neo>; from k@ailis.de on Thu, Mar 29, 2001 at 10:12:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same problem exists for the Toshiba 4000CDS. I think it is because
the OPL3SA2 in these machines is not using PNP. 

Probably the support for non-PNP chips broke during the recent update of
the driver (2.4.0 works perfectly).

Jens

On Thu, Mar 29, 2001 at 10:12:40AM +0200, Klaus Reimer wrote:
> Hi,
> 
> I have switched from 2.2.17 to 2.4.2 and now the sound is no longer working 
> on my Toshiba Tecra 8000 Notebook. In 2.2.17 I used the following modules:
-- 
Jens Taprogge

