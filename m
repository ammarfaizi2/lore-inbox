Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289685AbSAWLBa>; Wed, 23 Jan 2002 06:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289790AbSAWLBS>; Wed, 23 Jan 2002 06:01:18 -0500
Received: from ligsg2.epfl.ch ([128.178.78.4]:47387 "HELO ligsg2.epfl.ch")
	by vger.kernel.org with SMTP id <S289789AbSAWLBL>;
	Wed, 23 Jan 2002 06:01:11 -0500
Message-Id: <m16TL9R-021CWQC@ligsg2.epfl.ch>
Content-Type: text/plain; charset=US-ASCII
From: Jan Ciger <jan.ciger@epfl.ch>
Reply-To: jan.ciger@epfl.ch
Organization: EPFL
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Subject: Re: umounting
Date: Wed, 23 Jan 2002 12:01:08 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200201231040.g0NAeTKR009932@tigger.cs.uni-dortmund.de>
In-Reply-To: <200201231040.g0NAeTKR009932@tigger.cs.uni-dortmund.de>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I agree, but it probably does work only with floppies.
>
> Nope. It obviosly needs access (R/W) to the device/partition, and the right
> configuration. I've used it with floppies and parallel Zip drives, and
> sometime even with a loopback-mounted floppy image ;-)

Yeah, but you have to specify the format, and that is not that easy. It is a 
good way, how to screw your disks, when you do not know, what are you doing. 
I know, that it works with other things than floppies, but you have to have 
the format definition mentioned above. 

Jan
