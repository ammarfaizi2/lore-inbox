Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266596AbUBDUyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266536AbUBDUwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:52:31 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:41132 "EHLO
	nebula.ghetto") by vger.kernel.org with ESMTP id S266588AbUBDUuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:50:19 -0500
Date: Wed, 4 Feb 2004 21:46:22 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20269 (Ultra133 TX2) + Software RAID
Message-ID: <20040204204622.GA14326@larroy.com>
Reply-To: piotr@member.fsf.org
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <6FF5C83C-55FA-11D8-AC00-000A95CEEE4E@computeraddictions.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6FF5C83C-55FA-11D8-AC00-000A95CEEE4E@computeraddictions.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 02:08:31PM +1030, Ryan Verner wrote:

> And the machine is randomly locking up, and of course, on reboot, the 
> raid array is rebuilt.  Ouch.  Any clues as to why?  I'm sure the hard 
> drive hasn't failed as it's brand new; I suspect a chipset 
> compatibility problem or something.
> 
> R
> 

I have similar issues with 20269. I have two cards on one box doing sw raid5
on 6 ide drives. It only runs stably with 2.4.19
It has been many months since I assembled that box, and I've tried kernels
from 2.4.20-ac, 2.5.x, 2.6.2  and all hang after some time running.

I remember that pdcs also hanged a dual processor box.

Regards. Pedro.

