Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131085AbRAKKby>; Thu, 11 Jan 2001 05:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131088AbRAKKbo>; Thu, 11 Jan 2001 05:31:44 -0500
Received: from Cantor.suse.de ([194.112.123.193]:22020 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131085AbRAKKbh>;
	Thu, 11 Jan 2001 05:31:37 -0500
Date: Thu, 11 Jan 2001 11:31:34 +0100
From: Andi Kleen <ak@suse.de>
To: Danny ter Haar <dth@lin-gen.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Drivers under 2.4
Message-ID: <20010111113134.A20569@gruyere.muc.suse.de>
In-Reply-To: <20010110223836.A7321@gruyere.muc.suse.de> <Pine.LNX.4.30.0101110003020.30013-100000@prime.sun.ac.za> <93k1k0$87v$1@voyager.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <93k1k0$87v$1@voyager.cistron.net>; from dth@lin-gen.com on Thu, Jan 11, 2001 at 10:24:01AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 10:24:01AM +0000, Danny ter Haar wrote:
> Version number of the driver is the same but it doesn't work.
> 
> Any thoughts anyone ?

"Doesn't work" isn't a very useful bug report. What happens exactly?
Do the RX/TX/error counters increase when you try to send packets? 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
