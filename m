Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292715AbSBZTCL>; Tue, 26 Feb 2002 14:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292702AbSBZTBw>; Tue, 26 Feb 2002 14:01:52 -0500
Received: from [208.48.139.185] ([208.48.139.185]:16297 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S292712AbSBZTBl>; Tue, 26 Feb 2002 14:01:41 -0500
Date: Tue, 26 Feb 2002 11:01:34 -0800
From: David Rees <dbr@greenhydrant.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE error on 2.4.17
Message-ID: <20020226110134.B11982@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16fmJt-0001Xi-00@the-village.bc.nu> <006e01c1bef6$6dd78e40$030ba8c0@mistral>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <006e01c1bef6$6dd78e40$030ba8c0@mistral>; from turveysp@ntlworld.com on Tue, Feb 26, 2002 at 06:50:15PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 06:50:15PM -0000, Simon Turvey wrote:
> The drive's less than a year old :-(
> 
> Should I try disabling some of the UDMA stuff?

Age of the disk doesn't matter, they'll die at any age.  They seem to die
most frequently either within one year, or after 3 years.

Turning off UDMA probably won't help, it looks like it's time to restore
from backups.  If you try to recover data from the disk, make sure you mount
it in read-only mode if you can get the drive that far up if you reboot.

-Dave
