Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTKLO0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 09:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTKLO0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 09:26:23 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:10701 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262086AbTKLO0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 09:26:22 -0500
Date: Wed, 12 Nov 2003 15:26:19 +0100
From: bert hubert <ahu@ds9a.nl>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 sending out "need to fragment" on wrong interface
Message-ID: <20031112142619.GA21966@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Marc Haber <mh+linux-kernel@zugschlus.de>,
	linux-kernel@vger.kernel.org
References: <20031103072917.GA18992@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031103072917.GA18992@torres.ka0.zugschlus.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 08:29:17AM +0100, Marc Haber wrote:
> Hi,
> 
> I am using a Linux machine with freeS/WAN for my connectivity. The
> default route points to the IPSEC link. It has recently begun to send
> out "need to fragment" packets on the wrong interface.

Linux-kernel is mostly about unpatched kernels, have you taken this up with
the freeswan people?



-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
