Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSHZSy3>; Mon, 26 Aug 2002 14:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318224AbSHZSy3>; Mon, 26 Aug 2002 14:54:29 -0400
Received: from stargazer.compendium-tech.com ([64.156.208.76]:8196 "EHLO
	stargazer.compendium.us") by vger.kernel.org with ESMTP
	id <S318223AbSHZSy2>; Mon, 26 Aug 2002 14:54:28 -0400
Date: Mon, 26 Aug 2002 11:55:29 -0700 (PDT)
From: Kelsey Hudson <khudson@compendium.us>
X-X-Sender: khudson@betelgeuse.compendium-tech.com
To: Bernd Eckenfels <ecki@lina.inka.de>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 and full ipv6 - will it happen?
In-Reply-To: <20020821220313.GA25141@lina.inka.de>
Message-ID: <Pine.LNX.4.44.0208261149170.6621-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2002, Bernd Eckenfels wrote:

> On Wed, Aug 21, 2002 at 03:44:41PM -0600, Thunder from the hill wrote:
> > I'm getting through with bind9 pretty well, actually.
> 
> ip6.int? nibbles? reverse byte? ip6.arpa? A6? AAAA? 

It looks like nibble format and quad-A records are the de-facto standard. 
I'd expect them to become a finalized standard here shortly. BIND supports 
all these, however...

 Kelsey Hudson                                       khudson@compendium.us
 Software Engineer/UNIX Systems Administrator
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

