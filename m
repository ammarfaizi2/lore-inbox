Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWHYHiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWHYHiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWHYHiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:38:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48801 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751233AbWHYHiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:38:10 -0400
From: Andi Kleen <ak@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Unnecessary Relocation Hiding?
Date: Fri, 25 Aug 2006 09:38:06 +0200
User-Agent: KMail/1.9.3
Cc: "Dong Feng" <middle.fengdong@gmail.com>,
       "Christoph Lameter" <clameter@sgi.com>, linux-kernel@vger.kernel.org
References: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com> <200608250818.49139.ak@suse.de> <17646.42148.880959.99796@cargo.ozlabs.ibm.com>
In-Reply-To: <17646.42148.880959.99796@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608250938.06240.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 09:20, Paul Mackerras wrote:
> Andi Kleen writes:
> 
> > Best is to avoid undefined behaviour in new code.
> 
> Of course.  But do you have a way to implement per_cpu() without it?

I was describing the ideal, not the practical reality.

-Andi
