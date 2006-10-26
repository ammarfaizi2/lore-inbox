Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945996AbWJZXgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945996AbWJZXgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945997AbWJZXgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:36:42 -0400
Received: from mercury.sdinet.de ([193.103.161.30]:8860 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S1945996AbWJZXgm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:36:42 -0400
Date: Fri, 27 Oct 2006 01:36:41 +0200 (CEST)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Pavel Roskin <proski@gnu.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
In-Reply-To: <20061026230002.GR27968@stusta.de>
Message-ID: <Pine.LNX.4.64.0610270132290.6757@mercury.sdinet.de>
References: <1161807069.3441.33.camel@dv> <1161808227.7615.0.camel@localhost.localdomain>
 <20061025205923.828c620d.akpm@osdl.org> <1161859199.12781.7.camel@localhost.localdomain>
 <1161890340.9087.28.camel@dv> <20061026214600.GL27968@stusta.de>
 <1161901793.9087.110.camel@dv> <20061026230002.GR27968@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, Adrian Bunk wrote:

> On Thu, Oct 26, 2006 at 06:29:53PM -0400, Pavel Roskin wrote:
>> Anyway, I don't think it's relevant to ndiswrapper.
>> ...
>
> All non-GPL'ed modules are in a grey area, and the question isn't
> whether it's black or white but how light or dark the grey is...

ndiswrapper is GPL, but is (with the current code) not allowed to use the 
gpl-only'ed symbols.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
