Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUBDPDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 10:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUBDPDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 10:03:04 -0500
Received: from 213-176-151-74.in.is ([213.176.151.74]:28307 "EHLO
	schpilkas.net") by vger.kernel.org with ESMTP id S262355AbUBDPDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 10:03:00 -0500
Message-ID: <4021099A.6090209@hi.is>
Date: Wed, 04 Feb 2004 15:02:50 +0000
From: Gunnlaugur Thor Briem <gthb@hi.is>
User-Agent: Mozilla Thunderbird 0.5a (Windows/20040120)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Brahneborg <daniel.com@wtnord.net>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Status of Promise drivers?
References: <20031230200012.C14399@nettis.grimsta> <3FF1CCC1.3050304@pobox.com> <20040203192336.A5570@nettis.grimsta>
In-Reply-To: <20040203192336.A5570@nettis.grimsta>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Daniel Brahneborg wrote:

>>It's beta, and stable.
> 
> 
> Since I'm paranoid: What motherboards has it been tested and
> verified with?

Blessed are the paranoid: take a look at

http://bugzilla.kernel.org/show_bug.cgi?id=2011

(which hadn't been reported when Jeff Garzik called the driver stable)

Don't know about any other motherboards, but in any case your kernel is 
likely to hang when trying to use a PDC 20376 (on a motherboard, as in 
my case, or on a separate board), for the time being.

	- Gulli

