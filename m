Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288639AbSAQMlb>; Thu, 17 Jan 2002 07:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288643AbSAQMlW>; Thu, 17 Jan 2002 07:41:22 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:61198 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S288639AbSAQMlM>; Thu, 17 Jan 2002 07:41:12 -0500
Date: Thu, 17 Jan 2002 13:40:52 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Dave Jones <davej@suse.de>, Russell King <rmk@arm.linux.org.uk>,
        Guillaume Boissiere <boissiere@mediaone.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 17, 2001
Message-ID: <20020117124052.GC28788@arthur.ubicom.tudelft.nl>
In-Reply-To: <3C463337.24593.CD1AD57@localhost> <20020117100330.A12438@flint.arm.linux.org.uk> <20020117122135.C22171@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020117122135.C22171@suse.de>
User-Agent: Mutt/1.3.25i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 12:21:35PM +0100, Dave Jones wrote:
>  And the support for CPU clock/voltage scaling.  8-)
> 
>  Is the ARM side of this ready ? If so, I'll wrap up the
>  remaining x86 bits soon, and we can get this to a bigger
>  audience.

The basic support is stable. We need to sort out a nicer way to get the
memory timing variables, but that's only an initialisation issue we can
add later on.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
