Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbTCZRaz>; Wed, 26 Mar 2003 12:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbTCZRaz>; Wed, 26 Mar 2003 12:30:55 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:36364 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261800AbTCZRaz>; Wed, 26 Mar 2003 12:30:55 -0500
Date: Wed, 26 Mar 2003 17:43:02 +0000
Subject: Re: LVM/Device mapper breaks with -mm (was: Re: 2.5.66-mm1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: Erik Hensema <erik@hensema.net>, linux-kernel@vger.kernel.org
To: Andries Brouwer <aebr@win.tue.nl>
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
In-Reply-To: <20030326160350.GA11190@win.tue.nl>
Message-Id: <6437D130-5FB2-11D7-BBDF-000393CA5730@fib011235813.fsnet.co.uk>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday, March 26, 2003, at 04:03 PM, Andries Brouwer wrote:

> (I don't know whether such up-to-date utilities exist.)

Alasdair Kergon should be making a new release of the dm utilities in 
the next couple of days.  Once this has been done we will be free to 
fix the broken ioctl interface in 2.5.

- Joe

