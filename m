Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130490AbRCDTJI>; Sun, 4 Mar 2001 14:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRCDTI6>; Sun, 4 Mar 2001 14:08:58 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:44561 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130490AbRCDTIr>; Sun, 4 Mar 2001 14:08:47 -0500
Date: Sun, 4 Mar 2001 20:08:32 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Matthew Fredrickson <lists@frednet.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Slightly OT] x86 PROM project
Message-ID: <20010304200831.P25658@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010304122947.A11041@frednet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010304122947.A11041@frednet.dyndns.org>; from lists@frednet.dyndns.org on Sun, Mar 04, 2001 at 12:29:47PM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2001 at 12:29:47PM -0600, Matthew Fredrickson wrote:
> What does everybody think of the idea of trying to write a RISC PROM-like
> BIOS for the x86 architecture?
> 
> I've been tossing the idea around in my head for a while, and after I got
> my first SGI I realized that something like this would be fairly useful.
> Basically, I'm wondering if anybody is already doing something like this
> (not linuxBIOS, though the code for that could be a useful base).  Thanks.

Have a look at OpenBIOS:

  http://www.freiburg.linux.de/OpenBIOS/

The project wants to create an IEEE 1275-1994 compliant firmware, like
used by SUN (for example).


Erik
[who likes SUN firmware even more than SGI firmware]

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
