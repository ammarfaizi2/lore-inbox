Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318436AbSGYMH5>; Thu, 25 Jul 2002 08:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318437AbSGYMH5>; Thu, 25 Jul 2002 08:07:57 -0400
Received: from unthought.net ([212.97.129.24]:54690 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S318436AbSGYMH5>;
	Thu, 25 Jul 2002 08:07:57 -0400
Date: Thu, 25 Jul 2002 14:11:09 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RAID problems
Message-ID: <20020725121109.GA25999@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200207251354.04229.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200207251354.04229.roy@karlsbakk.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 01:54:04PM +0200, Roy Sigurd Karlsbakk wrote:
> hi all
> 
> What is there to do when the following happens:
> 
> a 16 drive RAID fails, giving me an error message telling 4 drives have gone 
> dead. In fact only one has.
> 
> How can I hack the superblock on the reminding disks to bring them "up", so 
> the kernel can start using the spare?

Just like the last time you asked this question on linux-kernel, the
answer is in the Software RAID HOWTO, section 6.1, and it is still
available at

http://unthought.net/Software-RAID.HOWTO/Software-RAID.HOWTO-6.html#ss6.1

Nothing has changed  :)

If you feel that the answer there is inadequate, please let me know.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
