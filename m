Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTCFBN6>; Wed, 5 Mar 2003 20:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbTCFBN6>; Wed, 5 Mar 2003 20:13:58 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:36248 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263366AbTCFBN5>;
	Wed, 5 Mar 2003 20:13:57 -0500
Date: Thu, 6 Mar 2003 02:24:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Meino Christian Cramer <mccramer@s.netic.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux 2.5.64]: Keyboard not responding/accepted
Message-ID: <20030306022416.A27688@ucw.cz>
References: <20030305.141101.41625623.mccramer@s.netic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030305.141101.41625623.mccramer@s.netic.de>; from mccramer@s.netic.de on Wed, Mar 05, 2003 at 02:11:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 02:11:01PM +0100, Meino Christian Cramer wrote:
>  Hi,
> 
>   ...for an unkown reason, my keyboard seems not to be accepted by the
>   newest Linux kernel (2.5.64) where under 2.4.20 it does.
> 
>   Furthermore, a couple of modules (also sound/fat/vfat...) do produce
>   unresolved symbols while compiling.
> 
>   I had to include them into the kernel.
> 
>   Does anyone has a hint for the keyboard problem?
>   What did I wrong ?

It doesn't seem you did anything wrong at the first glance. What does
'dmesg' say?

-- 
Vojtech Pavlik
SuSE Labs
