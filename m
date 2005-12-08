Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVLHON0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVLHON0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVLHON0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:13:26 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:15634 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932130AbVLHONZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:13:25 -0500
To: Rob Landley <rob@landley.net>
Cc: zine el abidine Hamid <zine46@yahoo.fr>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at page_alloc.c:117!
References: <20051205150530.91163.qmail@web30607.mail.mud.yahoo.com>
	<200512052306.18420.rob@landley.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: don't cry -- it won't help.
Date: Thu, 08 Dec 2005 14:13:03 +0000
In-Reply-To: <200512052306.18420.rob@landley.net> (Rob Landley's message of
 "6 Dec 2005 05:11:12 -0000")
Message-ID: <87d5k7vfrk.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Dec 2005, Rob Landley whispered secretively:
> On Monday 05 December 2005 09:05, zine el abidine Hamid wrote:
> 
>> PS : The user's manual definition of The Watch-Dog
>> Timer is : "a device to ensure thet standalone systems
>> can always recover from abnormal conditions that cause
>> the system to crash. These conditions may result from
>> an external EMI or software bug."
> 
> Such as the power supply filling up with dust and catching fire.
> 
> Rather an optimistic user's manual, really...

The Algol-68 people considered this problem long ago:
<http://gcc.gnu.org/ml/gcc-help/2004-11/msg00107.html>.

-- 
`Don't confuse the shark with the remoras.' --- Rob Landley

