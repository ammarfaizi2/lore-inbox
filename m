Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292910AbSB1Axa>; Wed, 27 Feb 2002 19:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293079AbSB1AxW>; Wed, 27 Feb 2002 19:53:22 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:22788 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S293100AbSB1AwE>; Wed, 27 Feb 2002 19:52:04 -0500
Date: Thu, 28 Feb 2002 01:51:52 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Allo! Allo! <lachinois@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel module ethics.
Message-ID: <20020228005152.GB8858@arthur.ubicom.tudelft.nl>
In-Reply-To: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com> <Pine.LNX.3.95.1020227164752.16918A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020227164752.16918A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.27i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 05:23:41PM -0500, Richard B. Johnson wrote:
> So, enter the compromise. Make your proprietary stuff in separate file(s)
> known only to your company. This keeps them trade secret. Compile them
> into a library. Provide that library with your module. The functions
> contained within that library should be documented as well as the
> calling parameters (a header file). This helps GPL maintainers
> determine if your library is broken.

Brilliant, this violates section 2b from the GPLv2. If that's OK with
you, see a lawyer first.

A couple of months ago Larry McVoy gave this excellent advice:

  If you really want to know where you stand, it'll cost you around
  $15K and that, in my opinion, is fine. If it isn't worth $15K to
  protect your code then it is worth so little to you that there really
  is no good reason not to just GPL it from the start.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
