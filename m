Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRFAVLN>; Fri, 1 Jun 2001 17:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbRFAVLC>; Fri, 1 Jun 2001 17:11:02 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:54544 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261561AbRFAVKt>; Fri, 1 Jun 2001 17:10:49 -0400
Date: Fri, 1 Jun 2001 23:06:05 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Ola Theander <ola.theander@connective.se>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: HowTo: Kernel verbose logging.
Message-ID: <20010601230605.A13054@arthur.ubicom.tudelft.nl>
In-Reply-To: <FC79D1F4C922D511983400104BC30388018E4F@DELL1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <FC79D1F4C922D511983400104BC30388018E4F@DELL1>; from ola.theander@connective.se on Fri, Jun 01, 2001 at 04:51:27PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2001 at 04:51:27PM +0200, Ola Theander wrote:
> Therefore I would like to know if it's possible to compile the used kernel
> (2.2.18) in some kind of verbose logging mode? Ultimately every kernel call
> should be logged, with parameters and everything. I realize that this
> probably isn't feasible but perhaps there is something that takes me
> halfway?

You probably want strace, see man strace.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
