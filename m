Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263035AbREaJFM>; Thu, 31 May 2001 05:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263036AbREaJFB>; Thu, 31 May 2001 05:05:01 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:32516 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S263035AbREaJEo>; Thu, 31 May 2001 05:04:44 -0400
Date: Thu, 31 May 2001 11:01:47 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Jose Carlos Garcia Sogo <jose@servidor.jaimedelamo.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.5-ac3
Message-ID: <20010531110147.B13054@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010531094556.A599@hal9000>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010531094556.A599@hal9000>; from jose@servidor.jaimedelamo.eu.org on Thu, May 31, 2001 at 09:45:56AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 09:45:56AM +0200, Jose Carlos Garcia Sogo wrote:
>    I've just got an oops with the 2.4.5-ac3 kernel. I have attached the log 
>   to this mail. I have also having more random dead locks, but I haven't 
>   catch any log of them. If I manage to get some logs, I'll send here also.
> 
>    Anyway, 2.4.5-ac3 is much more stable in my computer than vanilla 2.4.5, 
>   which was almost unusable. With 2.4.4, I had some problems also.
> 
>    I'm using NVIDIA's module for a TNT2 M64 card.

Try to reproduce the errors without the nvidia module. If you still get
oopses, report them over here. If not, complain to nvidia.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
