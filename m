Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLSBdw>; Mon, 18 Dec 2000 20:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLSBdn>; Mon, 18 Dec 2000 20:33:43 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:52748 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129228AbQLSBdc>; Mon, 18 Dec 2000 20:33:32 -0500
Date: Tue, 19 Dec 2000 01:57:33 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Ian Stirling <root@mauve.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User based routing?
Message-ID: <20001219015733.A960@arthur.ubicom.tudelft.nl>
In-Reply-To: <200012181946.TAA06870@mauve.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012181946.TAA06870@mauve.demon.co.uk>; from root@mauve.demon.co.uk on Mon, Dec 18, 2000 at 07:46:51PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 07:46:51PM +0000, Ian Stirling wrote:
> Are there any patches floating around?
> Basically to allow for example a server to dial out to ISP's on behalf
> of users, and give them full control over that interface.
> I know about UML, and it's not quite suited.
> I've not found anything searching archives, but maybe it's out there.

Sounds like you're looking for masqdialer. It doesn't give full control
to users (why should it), but it allows users to select from multiple
ISPs.


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
