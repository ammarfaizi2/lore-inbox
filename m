Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280784AbRKMHZ4>; Tue, 13 Nov 2001 02:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281239AbRKMHZs>; Tue, 13 Nov 2001 02:25:48 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:3705 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S280784AbRKMHZd>;
	Tue, 13 Nov 2001 02:25:33 -0500
Message-ID: <20011113082454.A20885@win.tue.nl>
Date: Tue, 13 Nov 2001 08:24:54 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: "Steven N. Hirsch" <shirsch@adelphia.net>, <linux-kernel@vger.kernel.org>
Subject: Re: fdisk doesn't know # of cylinders w/ 2.4.15pre2
In-Reply-To: <Pine.LNX.4.33.0111122057120.4249-100000@atx.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.33.0111122057120.4249-100000@atx.fast.net>; from Steven N. Hirsch on Mon, Nov 12, 2001 at 09:01:58PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 09:01:58PM -0500, Steven N. Hirsch wrote:

> I haven't seen any other reports of this, but fdisk is suddenly unable to 
> figure out the geometry of unpartitioned SCSI drives with 2.4.15pre2!

Yes, broken in 2.4.15pre2, fixed in 2.4.15pre3.
