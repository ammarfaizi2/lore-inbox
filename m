Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132806AbRAQKpD>; Wed, 17 Jan 2001 05:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132906AbRAQKox>; Wed, 17 Jan 2001 05:44:53 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:43792 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S132806AbRAQKoi>; Wed, 17 Jan 2001 05:44:38 -0500
Date: Wed, 17 Jan 2001 11:43:49 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: apark@cdf.toronto.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/PID/stat format
Message-ID: <20010117114349.D2929@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.21.0101160825450.1629-100000@blue.cdf.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101160825450.1629-100000@blue.cdf.utoronto.ca>; from apark@cdf.toronto.edu on Tue, Jan 16, 2001 at 08:26:46AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 08:26:46AM -0500, apark@cdf.toronto.edu wrote:
> What is the format of /proc/PID/stat for 2.2.x?

See function get_stat() in fs/proc/array.c.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
