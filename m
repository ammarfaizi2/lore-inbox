Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131347AbRDJTHZ>; Tue, 10 Apr 2001 15:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131873AbRDJTHP>; Tue, 10 Apr 2001 15:07:15 -0400
Received: from [216.18.82.208] ([216.18.82.208]:6148 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S131347AbRDJTHH>; Tue, 10 Apr 2001 15:07:07 -0400
Date: Tue, 10 Apr 2001 15:07:06 -0400
From: William Park <parkw@better.net>
To: Ryan Hairyes <rhairyes@lee.k12.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppp + kernel 2.4.3
Message-ID: <20010410150706.B1038@better.net>
Mail-Followup-To: Ryan Hairyes <rhairyes@lee.k12.nc.us>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200104101757.MAA03716@lee.k12.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200104101757.MAA03716@lee.k12.nc.us>; from rhairyes@lee.k12.nc.us on Tue, Apr 10, 2001 at 12:57:43PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 12:57:43PM -0500, Ryan Hairyes wrote:
> Could some one tell me what modules need to be selected to 
> make ppp successfully dialup and stay connected with 2.4.3?
> Or give me somewhere to look for this answer. 

ppp_async.  You can load it by 'modprobe ppp_async'.

--William Park, Open Geometry Consulting, Linux/Python/LaTeX/vim, 8 CPUs.
