Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbRELXx0>; Sat, 12 May 2001 19:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbRELXxQ>; Sat, 12 May 2001 19:53:16 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:33336 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S261353AbRELXxL>;
	Sat, 12 May 2001 19:53:11 -0400
Message-ID: <20010513015310.A7635@win.tue.nl>
Date: Sun, 13 May 2001 01:53:10 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux support for Microsoft dynamic disks?
In-Reply-To: <5.1.0.14.2.20010513000214.00ab3810@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <5.1.0.14.2.20010513000214.00ab3810@pop.cus.cam.ac.uk>; from Anton Altaparmakov on Sun, May 13, 2001 at 12:06:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 12:06:03AM +0100, Anton Altaparmakov wrote:

> Is anyone working on supporting the dynamic disk format introduced with 
> Windows 2000? If not, does anyone have the specs / any detailed info on the 
> on disk structures involved?

I once collected some stuff from the Microsoft Knowledge Base.
In
	http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
(hint: additions and corrections are welcome!)
you find partition type 42 that marks a partition table as legacy.

Unfortunately I do not have Windows 2000. (But I have DOS 4.01 :-)

Andries
