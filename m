Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264885AbUFAE2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264885AbUFAE2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 00:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUFAE2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 00:28:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:22717 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264885AbUFAE2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 00:28:21 -0400
Subject: Re: [Patch]: Fix rivafb's OF parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040601041604.GA2344@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1086064086.1978.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Jun 2004 14:28:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-01 at 14:16, Guido Guenther wrote:
> Hi,
> the attached patch fixes the EDID parsing for PPC on rivafb. It actually
> finds the EDID info in the OF Tree now. I grabbed this from BenHs Tree as
> of 2.6.5-rc3. The current code has no chance to work since it doesn't
> walk the device tree.
> This helps rivafb on PPC at least a bit further...
> Cheers,

You'll have more chances getting the patch picked up quickly if you send
it in the body of the mail, not as an attachment. Attachement are an
order of magnitude more painful to process for us.

(Make sure your mailer won't screw up space/tabs & line lenght though)

Ben.


