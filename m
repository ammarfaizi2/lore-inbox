Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVERHPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVERHPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVERHPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:15:00 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:9814 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262114AbVERHO6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:14:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BnHeXELc74FV9Pq8IV/xe+VGWTvmgBs0eKXP9hFRbcKPnV64np7iXV/wnax0UCyidCAEENvLEcFT/iKfNHgBuXWK8BHR/OeI1TJZg86gZbMEo6C6ySp++zwCV8AD74xp2ICpE40ctoFrjLxXsDlnvDOdRrFINBHeMZ5yjoYFEDc=
Message-ID: <2cd57c900505180014135f8dc3@mail.gmail.com>
Date: Wed, 18 May 2005 15:14:57 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc4-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050516021302.13bd285a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050516021302.13bd285a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/
> 
> - davem has set up a mm-commits mailing list so people can review things
>   which are added to or removed from the -mm tree.  Do
> 
>         echo subscribe mm-commits | mail majordomo@vger.kernel.org


I see patches being added to and removed from -mm tree.  Is it
possible to know the reason why they are removed, whether they are
merged upstream or dropped?
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
