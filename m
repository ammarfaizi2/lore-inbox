Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279079AbRJ2Iym>; Mon, 29 Oct 2001 03:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279075AbRJ2Iyd>; Mon, 29 Oct 2001 03:54:33 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:11918 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S279079AbRJ2IyO>;
	Mon, 29 Oct 2001 03:54:14 -0500
Date: Mon, 29 Oct 2001 08:54:48 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Shaya Potter <spotter@cs.columbia.edu>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: IBM T-23 crashes on resume from suspend, 2.4.12-ac5
Message-ID: <64526792.1004345688@[195.224.237.69]>
In-Reply-To: <Pine.LNX.4.33.0110282141540.19825-100000@tripoli.clic.cs.columbia.edu>
In-Reply-To: <Pine.LNX.4.33.0110282141540.19825-100000@tripoli.clic.cs.columb
 ia.edu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, 28 October, 2001 9:45 PM -0500 Shaya Potter 
<spotter@cs.columbia.edu> wrote:

> I had this problem with my T21 running xircom_tulip_cb (but not w/
> xircom_cb) for a while (now everything works fine).  The way I got around
> it for a while, was rmmod'ing the module b4 I went to suspend

T23 uses eepro100 (which in my case is built in). How did you
find which module was causing you the problem?

--
Alex Bligh
