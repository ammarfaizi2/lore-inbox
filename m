Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbSIYXuS>; Wed, 25 Sep 2002 19:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbSIYXuS>; Wed, 25 Sep 2002 19:50:18 -0400
Received: from zeus.kernel.org ([204.152.189.113]:42116 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261487AbSIYXuR>;
	Wed, 25 Sep 2002 19:50:17 -0400
Message-ID: <3D924D70.5060403@snapgear.com>
Date: Thu, 26 Sep 2002 09:57:36 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.5.38uc1 (MMU-less support)
References: <3D913223.6060801@snapgear.com> <20020925154511.GG30339@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg KH wrote:
> The driver patches look good, and I didn't see anything wrong with the
> exception of what Matthew already said.
> 
> But I did have a small question about the font:
> 
> 
>>. Motorola 68328 framebuffer
>>http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc1-fb.patch.gz
> 
> 
> The % and & characters are the same.  Is this intentional?

No :-)
Yank bug. Fixed now.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

