Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVKKEws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVKKEws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 23:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVKKEws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 23:52:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932343AbVKKEwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 23:52:47 -0500
Date: Thu, 10 Nov 2005 20:52:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: David.Ronis@mcgill.ca
Cc: ronis@ronispc.chem.mcgill.ca, gentoopower@yahoo.de,
       linux-kernel@vger.kernel.org
Subject: Re: Serious IDE problem still present in 2.6.14
Message-Id: <20051110205230.7a2ceced.akpm@osdl.org>
In-Reply-To: <1131680793.6300.20.camel@montroll.chem.mcgill.ca>
References: <Pine.LNX.4.44.0510301030120.26176-100000@coffee.psychology.mcmaster.ca>
	<1130689871.6348.3.camel@montroll.chem.mcgill.ca>
	<4365511C.7040903@yahoo.de>
	<1130713716.6348.7.camel@montroll.chem.mcgill.ca>
	<4365596F.4060105@yahoo.de>
	<1130785344.5932.6.camel@montroll.chem.mcgill.ca>
	<43673DFE.4000702@yahoo.de>
	<1131022436.6016.4.camel@montroll.chem.mcgill.ca>
	<436A9C30.3080705@yahoo.de>
	<1131680793.6300.20.camel@montroll.chem.mcgill.ca>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ronis <ronis@ronispc.chem.mcgill.ca> wrote:
>
> I've been busy and have been a bit late responding to this.  In short,
>  have a problem with disk performance on a HP Pavilion laptop in the
>  2.6.1[34] kernels (it works fine under 2.6.12.x).  I've summarized much
>  of the tests I've run on in a post to linux-kernel and linux-ide (when
>  we thought it was a problem in the ATIIXP module) at:
> 
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=112802950411697&w=2
> 
>  After working with Stefan for a bit, we determined that the problem is
>  in the ACPI modules (in fact setting ACPI=ht at boot fixes it, although
>  other things seem to break, as described below).  Stefan suggested I
>  repost the bug to the linux-kernel list, and so here it is.

The acpi team are very bugzilla-oriented.  Could you please open a bug
report for this, against acpi at bugzilla.kernel.org?

Thanks.
