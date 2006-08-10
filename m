Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWHJI0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWHJI0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWHJI0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:26:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:28648 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751449AbWHJI0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:26:14 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
Date: Thu, 10 Aug 2006 10:26:08 +0200
User-Agent: KMail/1.9.3
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>, stsp@aknet.ru,
       linux-kernel@vger.kernel.org
References: <200608100101_MC3-1-C796-F8CA@compuserve.com> <44DB0927.76E4.0078.0@novell.com>
In-Reply-To: <44DB0927.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608101026.08606.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 10:23, Jan Beulich wrote:
> >>> Chuck Ebbert <76306.1226@compuserve.com> 10.08.06 06:59 >>>
> >Part of the NMI handler is missing annotations.  Just moving
> >the RING0_INT_FRAME macro fixes it.  And additional comments
> >should warn anyone changing this to recheck the annotations.
> 
> I have to admit that I can't see the value of this movement; 

Should I drop it again? 

-Andi 
