Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWEEA1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWEEA1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 20:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWEEA1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 20:27:08 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:29919 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750839AbWEEA1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 20:27:06 -0400
Date: Fri, 5 May 2006 02:24:25 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: David Vrabel <dvrabel@cantab.net>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: Re: [PATCH 2/2] ipg: redundancy with mii.h
Message-ID: <20060505002425.GB9128@electric-eye.fr.zoreil.com>
References: <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost> <20060501231206.GD7419@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI> <20060502214520.GC26357@electric-eye.fr.zoreil.com> <20060502215559.GA1119@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605030913210.6032@sbz-30.cs.Helsinki.FI> <20060503233558.GA27232@electric-eye.fr.zoreil.com> <4459A4A6.1080207@cantab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4459A4A6.1080207@cantab.net>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Vrabel <dvrabel@cantab.net> :
[...]
> >    ipg: replace #define with enum
> >    
> >    Added some underscores to improve readability.
> >    
> >    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
> 
> Nack.  Register names in code should match those used in the 
> documentation (even if they are a bit unreadable).  Though I will 
> conceed that the available datasheet doesn't actually describe the 
> majority of the registers.

We will have to agree to disagree. Feel free to open a different
branch.

-- 
Ueimor
