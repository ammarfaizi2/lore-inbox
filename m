Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318002AbSGLVQx>; Fri, 12 Jul 2002 17:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318003AbSGLVQw>; Fri, 12 Jul 2002 17:16:52 -0400
Received: from stargazer.compendium-tech.com ([64.156.208.76]:56333 "EHLO
	stargazer.compendium.us") by vger.kernel.org with ESMTP
	id <S318002AbSGLVQw>; Fri, 12 Jul 2002 17:16:52 -0400
Date: Fri, 12 Jul 2002 14:18:37 -0700 (PDT)
From: Kelsey Hudson <khudson@compendium.us>
X-X-Sender: khudson@betelgeuse.compendium-tech.com
To: linux-kernel@vger.kernel.org
Subject: Re: What is the most stable kernel to date?
In-Reply-To: <1026494183.2561.151.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.4.44.0207121357570.1540-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jul 2002, Steven Cole wrote:

> Even with an early 2.4.x kernel, you can get good results.  I guess it
> really depends on your load.

indeed -- i had a box colocated in an ISP's basement running 2.4.2 on an 
abit bp6, twin 366MHz celerons, that stayed up for nearly 300 days. I 
think the grand total was 284 days or something ridiculous like that; 
impressive for both such an old release of the kernel and inherently 
broken hardware. the isp has since gone out of business due to financial 
problems, and that's the only reason the machine went down, otherwise i'm 
certain it would still be up now.

i still maintain that the latest kernel should be the one in use unless 
it's noted as a keep away kernel *ahem*2.4.11*ahem* -- the newest has got 
all the latest bug fixes, vm changes, features, etc. however, as always 
with varying hardware configurations, your mileage may vary

 Kelsey Hudson                                       khudson@compendium.us
 Software Engineer/UNIX Systems Administrator
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

