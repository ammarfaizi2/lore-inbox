Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318158AbSIEVbT>; Thu, 5 Sep 2002 17:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSIEVbT>; Thu, 5 Sep 2002 17:31:19 -0400
Received: from adsl-63-201-183-186.dsl.lsan03.pacbell.net ([63.201.183.186]:53909
	"HELO pobox.com") by vger.kernel.org with SMTP id <S318158AbSIEVbS>;
	Thu, 5 Sep 2002 17:31:18 -0400
Date: Thu, 5 Sep 2002 14:35:55 -0700
From: "Ryan S. Upton" <rupton@pobox.com>
To: Ben Greear <greearb@candelatech.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: DFE-580TX problems you posted on 05-24-02
Message-ID: <20020905213555.GB31524@pobox.com>
References: <20020723203037.GA29459@pobox.com> <3D3DCD2C.1050004@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3DCD2C.1050004@candelatech.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, and hopefully this too will lighten your load. I was able to find a driver that does work for the DFE-580TX. It appears to be a derrivitive of DB's sundance 1.03a. It is being distributed from a dlink site and the license "MODULE_LICENSE" tag has been modified (removed) so this may taint GPL-Free-LGPL pristine machines, but the GPL still remains at the top... (?) IANAL. 

Thanks to whoever modified this to work with the DFE-580TX (MIND THE LICENSE THOUGH!) and to everyone who posted allowing me to find this. Here's the link. 

http://tsd.dlink.com.tw/info.nsf/80d023dbef05f90048256adf002a91be/6dbbd6ab52943b1348256bd6002a4b4e?OpenDocument

-R
Ryan S. Upton
ryanu@pobox.com

On Tue, Jul 23, 2002 at 02:39:56PM -0700, Ben Greear wrote:
> Ryan S. Upton wrote:
> >I apologise for this imposition. I'm sending you mail that only asks for 
> >help. I was hoping you found a solution to the problems you were seeing 
> >about the Dlink DEF-580tx. I say the message you sent into kernel.org. 
> >http://www.uwsg.iu.edu/hypermail/linux/kernel/0205.3/0013.html
> >
> >I've been looking for three days for a solution to the same problems iyou 
> >described. I am seeing these with a newly compiled 2.4.18 kernel. Have you 
> >had any success since May? 
> >Thanks,
> >-R
> >
> 
> I'm CC'ing LMKL in hopes that this gets in the search engines so that I
> quit getting 5 of these mails a day :)
> 
> The fix for the DFE-580tx in Linux is to either download the driver
> from dlink's site (I don't have the exact URL, but you can find it if
> you look.), or perhaps use Becker's latest driver from www.scyld.com.
> 
> I hear the kernel will be updated with a working driver very soon (maybe
> it has already??)
> 
> Thanks,
> Ben
> 
> 
> -- 
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
> 
