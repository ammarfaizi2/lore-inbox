Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317994AbSHHVz1>; Thu, 8 Aug 2002 17:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318019AbSHHVz1>; Thu, 8 Aug 2002 17:55:27 -0400
Received: from [63.204.6.12] ([63.204.6.12]:59837 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S317994AbSHHVz0>;
	Thu, 8 Aug 2002 17:55:26 -0400
Date: Thu, 8 Aug 2002 17:59:06 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation 
In-Reply-To: <21750.1028835889@redhat.com>
Message-ID: <Pine.LNX.4.33.0208081707370.26999-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, David Woodhouse wrote:

>
> scottm@somanetworks.com said:
> >  you have any objection to this boot time reservation stuff going in
> > for now as a cPCI only thing?  I can imagine other solutions that use
> > DMI scans or the like to detect cPCI master cards and grab chunks of
> > the resource space(s) for the hotswap buses, but don't have any clever
> > ideas on reliable heuristics for knowing how big those chunks should
> > be for a given card.
>
> No objections. I can't see any 'proper' fix other than adding the ability
> to relocate live cards. And I don't reckon that's going to happen.

Cool, thanks.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


