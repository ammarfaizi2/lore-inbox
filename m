Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264426AbUFCWlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbUFCWlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 18:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUFCWlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 18:41:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:18392 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264426AbUFCWlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 18:41:03 -0400
Subject: Re: [Patch]: Fix rivafb's OF parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040601135335.GA5406@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix>
	 <1086064086.1978.0.camel@gaston>  <20040601135335.GA5406@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1086302421.1838.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 08:40:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-01 at 23:53, Guido Guenther wrote:
> On Tue, Jun 01, 2004 at 02:28:06PM +1000, Benjamin Herrenschmidt wrote:
> > You'll have more chances getting the patch picked up quickly if you send
> > it in the body of the mail, not as an attachment. Attachement are an
> > order of magnitude more painful to process for us.
> Next try:
> 
> the attached patch fixes the EDID parsing for PPC on rivafb. It actually
> finds the EDID info in the OF Tree now. I grabbed this from BenHs Tree as
> of 2.6.5-rc3. The current code has no chance to work since it doesn't
> walk the device tree.
> This helps rivafb on PPC at least a bit further...
> Cheers,

Your tab/spacing seem to be broken.. Fix the tabs or check that your
mailer isn't screwing them up.

Ben.


