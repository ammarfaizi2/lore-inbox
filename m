Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWG1WHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWG1WHv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 18:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWG1WHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 18:07:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:15480 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751326AbWG1WHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 18:07:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ocK3jrkxJgCIiogD/aBMccsplxsbEuPAKgbNKiBm2s5NiCPX1gxmzKVBE6jqW+YbmuLERJ2vjPDo0Cd/aPLbYv1asxt7dff0Nuchmj9S9Ua7qu/l/0itA+wL/VvcYtwDx6dWpylDdyiwd+mi6ysGOe5KU7se3ZVYzu4zIF2wKjw=
Message-ID: <41840b750607281507x35ff597bi7158758685159bab@mail.gmail.com>
Date: Sat, 29 Jul 2006 01:07:48 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] DMI: Decode and save OEM String information
Cc: "Henrique de Moraes Holschuh" <hmh@debian.org>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Matt Domsch" <Matt_Domsch@dell.com>,
       "Brown, Len" <len.brown@intel.com>
In-Reply-To: <200607281508.21312.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com>
	 <200607281237.45576.bjorn.helgaas@hp.com>
	 <41840b750607281352q715ad417l927f868aff306410@mail.gmail.com>
	 <200607281508.21312.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Going off lists)

On 7/29/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Friday 28 July 2006 14:52, Shem Multinymous wrote:
> > Anyway, this patch is independent of the ThinkPad case; DMI
> > information is there for drivers to see it, after all, so the kernel
> > should make it possible. Can I get a Signed-off-by?
>
> If you're the author, you're the one to supply the "Signed-off-by";
> see Documentation/SubmittingPatches for exactly what it means.

Sorry, I misunderstood the protocol. I guess I'm asking for an
Acked-by, except I don't see that one mentioned in Documentation/*.

Anyway, if there are no more comments I'll repost with the missing
"Signed-off-by: Shem Multinymous <multinymous@gmail.com>".

  Shem
