Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTKDH26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 02:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTKDH26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 02:28:58 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:64961 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263775AbTKDH26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 02:28:58 -0500
Date: Tue, 4 Nov 2003 08:28:57 +0100
From: bert hubert <ahu@ds9a.nl>
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm1: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Message-ID: <20031104072856.GA15243@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Gabor MICSKO <gmicsko@szintezis.hu>,
	LKML <linux-kernel@vger.kernel.org>
References: <1067887823.953.10.camel@gmicsko03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067887823.953.10.camel@gmicsko03>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 08:30:21PM +0100, Gabor MICSKO wrote:
> Hi!
> 
> I've got the following messages with 2.6.0-test9-mm1 (with exec-shield).
> Vanilla 2.6.0-test9 seems ok.

If you have the opportunity, try running memtest86 for a night. It can be
found on http://www.memtest86.com/

Not sure why these reports crop up suddenly but perhaps they were previously
being ignored.



-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
