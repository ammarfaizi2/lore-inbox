Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135306AbREBOMF>; Wed, 2 May 2001 10:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbREBOL4>; Wed, 2 May 2001 10:11:56 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:62732 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S135276AbREBOLj>; Wed, 2 May 2001 10:11:39 -0400
Date: Wed, 2 May 2001 16:11:19 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Deepika Kakrania <deepika@sasken.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: randon number generator in kernel..
Message-ID: <20010502161119.D11059@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.GSO.4.30.0105021918490.21323-100000@suns3.sasi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0105021918490.21323-100000@suns3.sasi.com>; from deepika@sasken.com on Wed, May 02, 2001 at 07:24:39PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 07:24:39PM +0530, Deepika Kakrania wrote:
>   Can anyone tell me whether there is already any function to generate
> random number inside kernel. If there is one what is that?

See drivers/char/random.c


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
