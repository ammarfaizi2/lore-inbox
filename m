Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129945AbRBZUMZ>; Mon, 26 Feb 2001 15:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129961AbRBZUMQ>; Mon, 26 Feb 2001 15:12:16 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:28475 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S129945AbRBZUL4>;
	Mon, 26 Feb 2001 15:11:56 -0500
Message-ID: <20010226211150.A17477@win.tue.nl>
Date: Mon, 26 Feb 2001 21:11:50 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org,
        aeb@cwi.nl
Subject: Re: partition table: chs question
In-Reply-To: <20010225163534.A12566@dungeon.inka.de> <20010225224729.A16353@win.tue.nl> <002201c09f87$5ce75640$f6976dcf@nwfs> <20010226041156.A16707@win.tue.nl> <20010226112407.C23495@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010226112407.C23495@vger.timpanogas.org>; from Jeff V. Merkey on Mon, Feb 26, 2001 at 11:24:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 11:24:07AM -0700, Jeff V. Merkey wrote:
> On Mon, Feb 26, 2001 at 04:11:56AM +0100, Guest section DW wrote:

> > (See http://www.win.tue.nl/~aeb/partitions/partition_types-1.html )
> > Are types 57 and 77, labeled "VNDI Partition", actually in use?
> 
> No.  They are not.  65, and 77 are the ones in use.  Novell was using 
> 67 for Wolf Mountain, but for NSS, they are exclusively using 69.

Wait! 57 and 77 are not in use, but 65 and 77 are?
(Is the second 77 a typo for 66 or 67?)

A lot of partition IDs are attributed to Novell.
64 (Netware 286) and 65 (Netware 386) are well established, and
you tell me 66 is Netware SMS, 67 is Wolf Mountain and 69 is Netware NSS.
But also 51 and 68 occur in reports. Do you know anything about those?

Andries
