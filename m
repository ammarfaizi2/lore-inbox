Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRBTLA7>; Tue, 20 Feb 2001 06:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130037AbRBTLAt>; Tue, 20 Feb 2001 06:00:49 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:32780 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129790AbRBTLAl>; Tue, 20 Feb 2001 06:00:41 -0500
Date: Tue, 20 Feb 2001 11:57:39 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Thomas Lau <lkthomas@hkicable.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: where can I found AMD k6-2+ optimized gcc ?
Message-ID: <20010220115739.D8042@arthur.ubicom.tudelft.nl>
In-Reply-To: <3A91611F.8082FEC5@hkicable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A91611F.8082FEC5@hkicable.com>; from lkthomas@hkicable.com on Tue, Feb 20, 2001 at 02:08:31AM +0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 02:08:31AM +0800, Thomas Lau wrote:
> anyone have idea?
> I think someone was done before to optimizer AMD K6-2+ CPU in gcc patch.

Yes, it's in the upcoming gcc-3.0. No, don't use it to build kernels
for production machines.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
