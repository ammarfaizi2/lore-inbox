Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262238AbTCMLhZ>; Thu, 13 Mar 2003 06:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262241AbTCMLhY>; Thu, 13 Mar 2003 06:37:24 -0500
Received: from unthought.net ([212.97.129.24]:12730 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262238AbTCMLhY>;
	Thu, 13 Mar 2003 06:37:24 -0500
Date: Thu, 13 Mar 2003 12:48:09 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Cc: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: NetFlow export
Message-ID: <20030313114809.GA29730@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>
References: <87adfza5kb.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87adfza5kb.fsf@deneb.enyo.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 12:07:00PM +0100, Florian Weimer wrote:
> Are there any patches which implement kernel-based NetFlow data
> export?

Netramet works very well - it's userspace (and very flexible indeed).

No need to clutter the kernel with an SNMP stack too, if you ask me.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
