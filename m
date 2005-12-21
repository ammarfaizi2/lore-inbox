Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVLUKlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVLUKlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 05:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVLUKlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 05:41:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:30184 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932353AbVLUKln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 05:41:43 -0500
Date: Wed, 21 Dec 2005 11:41:38 +0100
From: Olaf Hering <olh@suse.de>
To: Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: console on POWER4 not working with 2.6.15
Message-ID: <20051221104138.GA17580@suse.de>
References: <20051220204530.GA26351@suse.de> <20051220214525.GB7428@pb15.lixom.net> <20051220220932.GA29092@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051220220932.GA29092@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Dec 20, Olaf Hering wrote:

> I remember someone mentioned that a 43p 150 did not boot if the keyboard
> is connected. Will try that tomorrow. The git2-3 diff is huge, so maybe
> this hint helps.

Yes, removing the keyboard helps.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
