Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSLOPvd>; Sun, 15 Dec 2002 10:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSLOPvd>; Sun, 15 Dec 2002 10:51:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50950 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261996AbSLOPv3>; Sun, 15 Dec 2002 10:51:29 -0500
Date: Sun, 15 Dec 2002 15:59:21 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serial_pci_tbl is incorrect for some Titan devices
Message-ID: <20021215155921.C6486@flint.arm.linux.org.uk>
Mail-Followup-To: Brian Murphy <brian@murphy.dk>,
	linux-kernel@vger.kernel.org
References: <3DFC9E8E.8040702@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DFC9E8E.8040702@murphy.dk>; from brian@murphy.dk on Sun, Dec 15, 2002 at 04:23:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 04:23:58PM +0100, Brian Murphy wrote:
> There are still some Titan devices defined around line 990 in
> 8250_pci which use the old format for this structure. Is there
> any chance that the patch I submitted a while ago to fix this
> problem will be accepted?

No, because as far as I can tell, I didn't receive such a patch.
The only patch I have that's outstanding from you is for the IRQ255
problem - I believe at the time there was some debate about whether
it was the right way to handle the problem or not.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

