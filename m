Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136103AbREGMJ6>; Mon, 7 May 2001 08:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136098AbREGMJi>; Mon, 7 May 2001 08:09:38 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:2313 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S136094AbREGMJ3>; Mon, 7 May 2001 08:09:29 -0400
Date: Mon, 7 May 2001 14:09:14 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Chandrashekar Nagaraj <chandrashekar.nag@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20010507140914.K18405@arthur.ubicom.tudelft.nl>
In-Reply-To: <004101c0d6ea$44ec44c0$4433a8c0@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004101c0d6ea$44ec44c0$4433a8c0@wipro.com>; from chandrashekar.nag@wipro.com on Mon, May 07, 2001 at 05:08:43PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 05:08:43PM +0530, Chandrashekar Nagaraj wrote:
> 	i want to know how to read tab without a terminating character,
> ie., if i use getchar() i have to enter '\n' after tab to read tab,
> same is the case with read system call and scanf. 

This is off topic for this list, but anyway.

Read man cfmakeraw, and/or get a copy of "Advanced programming in the
UNIX environment" by W. Richard Stevens.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
