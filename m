Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWIRUwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWIRUwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWIRUwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:52:16 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:1421 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964981AbWIRUwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:52:15 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: George Nychis <gnychis@cmu.edu>
Subject: Re: memory suspension resume broken on thinkpad x60s
Date: Mon, 18 Sep 2006 22:55:35 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <450EBABA.7040401@cmu.edu>
In-Reply-To: <450EBABA.7040401@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609182255.36190.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 18 September 2006 17:26, George Nychis wrote:
> Hey guys,
> 
> At one point, I had memory suspension and disk suspension working 
> beautifully on my x60s with the 6 patch set from Forrest Zhao:
> 
> x60s patches # md5sum ahci-patch*
> 71d9cfb75eb93c441e582b345fe48d83  ahci-patch1
> 372d229a5ef4e89d9e96f61391f72f4d  ahci-patch2
> e867b2f28e3d144fae000083d83da24d  ahci-patch3
> 5d16c9e54606fbd1a29966351ed32a9b  ahci-patch4
> f40a8c2993d0b8cb164c224ceda4e2f9  ahci-patch5
> 27676e415cc928d640287c00fbad6652  ahci-patch6
> 
> So anyways, I hadn't used it in a month, after several kernel changes, 
> however I have applied the patches to every kernel.
> 
> Suspend to disk works beautifully, no problems at all.
> 
> Suspend to memory seems to work, it quickly brings up the "moon" symbol 
> on the x60s control board, and powers down everything else.
> 
> Then I shut the lid, and when I reopen it, it seems as though the disk 
> resumes, and everything else resumes, however my screen never resumes. 
> I cannot get the screen to light up at all.  I am not sure if the OS has 
> completely resumed or not because I can't see anything.  However there 
> is hard disk activity.
> 
> Any ideas?

Go here: http://en.opensuse.org/S2ram

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
