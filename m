Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310459AbSCLHEU>; Tue, 12 Mar 2002 02:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310464AbSCLHEM>; Tue, 12 Mar 2002 02:04:12 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:47844 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S310457AbSCLHD7>; Tue, 12 Mar 2002 02:03:59 -0500
Date: Mon, 11 Mar 2002 20:34:14 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Alex Riesen <Alexander.Riesen@synopsys.COM>
Subject: Re: directory notifications lost after fork?
Message-ID: <20020311203414.A866@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20020311122701.A9718@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311122701.A9718@riesen-pc.gr05.synopsys.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch worked for 2.4.19-pre2-ac2+preempt.


> this should fix your problem:
>
>	ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre2aa2/00_dnotify-fl_owner-1
>
>	Andrea

