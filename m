Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277117AbRJDEa7>; Thu, 4 Oct 2001 00:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277119AbRJDEat>; Thu, 4 Oct 2001 00:30:49 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:30420 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277117AbRJDEam>; Thu, 4 Oct 2001 00:30:42 -0400
Date: Thu, 4 Oct 2001 00:31:11 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no counters in /proc/net/dev with the ns83820 driver?
Message-ID: <20011004003110.A12680@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110032111510.1941-100000@twin.uoregon.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110032111510.1941-100000@twin.uoregon.edu>; from joelja@darkwing.uoregon.edu on Wed, Oct 03, 2001 at 09:29:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 09:29:41PM -0700, Joel Jaeggli wrote:
> this strike me as a bit odd.
> 
> with the driver version 1.34 (kernel is 2.4.9ac7) no statistics are
> collected in /proc/net/dev, output follows

Upgrade to a newer kernel.  Version 0.12 (some other cvs version) has 
statistics counters.

		-ben
