Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268363AbTBSLy4>; Wed, 19 Feb 2003 06:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268368AbTBSLy4>; Wed, 19 Feb 2003 06:54:56 -0500
Received: from holomorphy.com ([66.224.33.161]:25753 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268363AbTBSLyz>;
	Wed, 19 Feb 2003 06:54:55 -0500
Date: Wed, 19 Feb 2003 04:04:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: David Ford <david+cert@blue-labs.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62
Message-ID: <20030219120400.GV29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Duncan Sands <baldrick@wanadoo.fr>,
	David Ford <david+cert@blue-labs.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com> <200302191204.55573.baldrick@wanadoo.fr> <20030219110705.GU29983@holomorphy.com> <200302191258.59102.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302191258.59102.baldrick@wanadoo.fr>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 February 2003 12:07, William Lee Irwin III wrote:
>> Well, there's always the NMI oopser + serial console to log oopses.
>> X seems to make VGA console unavailable, plus it's not loggable.

On Wed, Feb 19, 2003 at 12:58:58PM +0100, Duncan Sands wrote:
> AMD K6-2 w/o APIC...

Hmm. Could you be convinced to upgrade to a machine with a real
interrupt controller?

Well, hook up serial anyway. Maybe it's oopsing and you just can't
see what it's trying to printk.


-- wli
