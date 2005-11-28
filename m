Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVK1Tf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVK1Tf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVK1Tf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:35:57 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:10210 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S932204AbVK1Tf4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:35:56 -0500
Date: Mon, 28 Nov 2005 21:35:51 +0200
From: Ville Herva <vherva@vianova.fi>
To: mgross <mgross@linux.intel.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, bunk@stusta.de,
       folkert@vanheusden.com, linux-kernel@vger.kernel.org
Subject: Re: capturing oopses
Message-ID: <20051128193551.GG6966@vianova.fi>
Reply-To: vherva@vianova.fi
References: <20051122130754.GL32512@vanheusden.com> <20051126193358.GF22255@vianova.fi> <20051127204132.2b0d7406.rdunlap@xenotime.net> <200511280820.02473.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511280820.02473.mgross@linux.intel.com>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 08:20:02AM -0800, you [mgross] wrote:
> 
> You know some platforms that perserve the memory above some addresses across 
> warm boots.  For such platforms, one could reserve a buffer in that area can 
> copy the sys log buffer to it on panic along with a bit pattern that could be 
> searched for upon the next boot.

I think there was a patch to do this a couple of years ago. 
 
The only references I can find now are:

http://groups.google.com/groups?q=%22Utility+module+to+capture+OOPS+output+over+reboot%22&hl=en&selm=fa.fbd0l7v.14hau3n%40ifi.uio.no&rnum=1)
http://marc.theaimsgroup.com/?l=linux-kernel&m=93077831203565&w=2


-- v -- 

v@iki.fi

