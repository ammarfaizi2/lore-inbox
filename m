Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752458AbWCGLuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbWCGLuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbWCGLuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:50:25 -0500
Received: from cernmx08.cern.ch ([137.138.166.172]:34280 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1752172AbWCGLuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:50:25 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=B5NbETj0wxIefT1286gDgZlmLcbdWKpuWyPG6vf3c1f2l7wWW/xiyOik8aa3C5DX+TWcNYLBGpIU+HLpmuOqV4ueX3AeJShPo9YAItzR3FfYlQs4oZDnbU0poXuGAt1a;
Keywords: CERN SpamKiller Note: -51 Charset: west-latin
X-Filter: CERNMX08 CERN MX v2.0 051012.1312 Release
Message-ID: <440D7384.5030307@cern.ch>
Date: Tue, 07 Mar 2006 12:50:28 +0100
From: Jiri Tyr <jiri.tyr@cern.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060128)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: video4linux-list@redhat.com, Michel Bardiaux <mbardiaux@mediaxim.be>
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
References: <440C5672.7000009@cern.ch> <200603061656.18846.duncan.sands@math.u-psud.fr>
In-Reply-To: <200603061656.18846.duncan.sands@math.u-psud.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2006 11:50:20.0102 (UTC) FILETIME=[4F527660:01C641DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michel Bardiaux wrote:

 >I dont see anything suspicious conflict. But 'overlay' has been
 >mentionned, I'm not familiar with that but I assume it means you're
 >doing video grabs directly to the X display, right?

Yes, I'm using xawtv + overlay directly to the X display :0.0. Is better 
way to use it with some WM (KDE, Gnome, ...)?

 >Then it could be a problem with the graphics card or its driver.

On the mainboard is graphics card Intel 915. I have tryed it with i810 
(with / without DRI) and vesa driver. I have also tryed PCIE graphics 
card from ATI. In all of those cases the PC freeze and as well as if is 
in PCI slot only ONE tuner!

 >Just my 2 cents, because I am totally unfamiliar with such uses, sounds
 >like a problem for the MythTV crowd.

I'm totally lost! I have here 25 PCs (100 tuners) what always freeze ;o(

Jiri

