Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278261AbRJMEFD>; Sat, 13 Oct 2001 00:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278264AbRJMEEx>; Sat, 13 Oct 2001 00:04:53 -0400
Received: from femail6.sdc1.sfba.home.com ([24.0.95.86]:15553 "EHLO
	femail6.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278261AbRJMEEo>; Sat, 13 Oct 2001 00:04:44 -0400
Date: Sat, 13 Oct 2001 00:06:01 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.12-ac1
Message-ID: <20011013000601.A564@zero>
In-Reply-To: <20011012141726.A27516@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011012141726.A27516@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Fri, Oct 12, 2001 at 02:17:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 02:17:26PM +0100, Alan Cox wrote:
> *	Decidedly experimental. Use with caution
> 2.4.12-ac1

the thrashing i complained of is gone. when running big diffs through
patch, it will thrash at the same places, but only for about a quarter
second. before, it would keep thrashing until all io was done or if i hit
scroll lock.

i did get this, however, when my initscripts ran:

task `ifconfig' exit_signal 20 in reparent_to_init

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
