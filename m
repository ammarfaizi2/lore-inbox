Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752177AbWAETkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbWAETkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbWAETky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:40:54 -0500
Received: from isilmar.linta.de ([213.239.214.66]:54687 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1752177AbWAETkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:40:53 -0500
Date: Thu, 5 Jan 2006 20:40:50 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Ben Collins <ben.collins@ubuntu.com>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/15] Ubuntu patch sync
Message-ID: <20060105194050.GA14208@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Ben Collins <ben.collins@ubuntu.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel@vger.kernel.org
References: <0ISL003P992UCY@a34-mta01.direcway.com> <20060104140627.1e89c185@dxpl.pdx.osdl.net> <1136412768.4430.28.camel@grayson> <Pine.LNX.4.61.0601050848570.10161@yvahk01.tjqt.qr> <20060105185206.GA13021@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105185206.GA13021@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 07:52:06PM +0100, Francois Romieu wrote:
> >  Group 2:
> >  - rt2400,rt2500,rt2570 "1.1.0" from sf.net/projects/rt2400
> >  - rt2x00 "2.0", also sf.net/projects/rt2400
> 
> 
> Afaiks it does not apply to the rt2x00 drivers. However these are still
> strongly different from the ideal in-kernel driver. CodingStyle (arguable)
> and locking - broken - would need more work. This is not yet another
> 80211 subsystem

Currently this is true, but AFAIK they intend to switch to the DeviceScape
stack right now (between rt2x00 2.0b3 and 2.0b4).

	Dominik
