Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281092AbRKEMYK>; Mon, 5 Nov 2001 07:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281095AbRKEMYB>; Mon, 5 Nov 2001 07:24:01 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2323 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281092AbRKEMXs>; Mon, 5 Nov 2001 07:23:48 -0500
Date: Mon, 5 Nov 2001 13:23:46 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: disk throughput
Message-ID: <20011105132346.B5805@emma1.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Nov 2001, Andrew Morton wrote:

> Numbers.  The machine has 768 megs; the disk is IDE with a two meg cache.
> The workload consists of untarring, tarring, diffing and removing kernel
> trees. This filesystem is 21 gigs, and has 176 block groups.

Does that IDE disk run with its write cache enabled or disabled?
