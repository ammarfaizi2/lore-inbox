Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132789AbRDXF1W>; Tue, 24 Apr 2001 01:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132796AbRDXF1M>; Tue, 24 Apr 2001 01:27:12 -0400
Received: from smtp3.xs4all.nl ([194.109.127.132]:62981 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S132789AbRDXF07>;
	Tue, 24 Apr 2001 01:26:59 -0400
From: thunder7@xs4all.nl
Date: Tue, 24 Apr 2001 06:42:44 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Matrox FB console driver
Message-ID: <20010424064244.A5223@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <Pine.LNX.4.20.0104232001580.188-100000@bigandy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.20.0104232001580.188-100000@bigandy>; from naclos@swbell.net on Mon, Apr 23, 2001 at 08:06:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 08:06:11PM -0500, Andy Carlson wrote:
> I was playing around with a program that I was using to time differences
> between kernels (a silly prime program that puts out 1000000 primes).  I
> noticed a very strange behaviour.  On a fresh boot, with the Penguin
> pictures that the Matrox FB driver puts up, the prime program runs
> 1 minute, 30 seconds.  If I reset, it still runs 1M30S.  If I start X,
> and exit, it runs 48 seconds.  Is this a known behaviour?  Thanks.

is there any change in /proc/mtrr before and after X?

Good luck,
Jurriaan
-- 
BOFH excuse #176:

vapors from evaporating sticky-note adhesives
GNU/Linux 2.4.3-ac12 SMP/ReiserFS 2x1743 bogomips load av: 0.13 0.03 0.01
