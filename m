Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132118AbRDTWmn>; Fri, 20 Apr 2001 18:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132121AbRDTWmc>; Fri, 20 Apr 2001 18:42:32 -0400
Received: from ns.suse.de ([213.95.15.193]:38927 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132118AbRDTWmV>;
	Fri, 20 Apr 2001 18:42:21 -0400
Date: Sat, 21 Apr 2001 00:40:27 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4-pre5 compile error
Message-ID: <20010421004027.D18359@pingi.muc.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010420201709.H25081@mandel.hjb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010420201709.H25081@mandel.hjb.de>; from hjb@pro-linux.de on Fri, Apr 20, 2001 at 08:17:09PM +0200
Organization: SuSE Muenchen GmbH
X-Operating-System: Linux 2.2.18-SMP i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 08:17:09PM +0200, Hans-Joachim Baader wrote:
> Hi,
> 
> in case it isn't already known:
> 
> isdn_net.c: In function `isdn_ciscohdlck_dev_ioctl':
> isdn_net.c:1455: structure has no member named `cisco_keepalive_period'
> 

Fix was posted last night here.

-- 
Karsten Keil
SuSE Labs
ISDN development
