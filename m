Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSAUSqc>; Mon, 21 Jan 2002 13:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287816AbSAUSqW>; Mon, 21 Jan 2002 13:46:22 -0500
Received: from adsl-65-42-130-74.dsl.chcgil.ameritech.net ([65.42.130.74]:19040
	"EHLO localhost") by vger.kernel.org with ESMTP id <S285589AbSAUSqL>;
	Mon, 21 Jan 2002 13:46:11 -0500
Date: Mon, 21 Jan 2002 12:46:09 -0500
From: Mike Phillips <phillim2@home.com>
To: Kent E Yoder <yoder1@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
Message-ID: <20020121174609.GA5071@home.com>
In-Reply-To: <OFA6159B1C.9D145D7A-ON85256B48.005BBAF9@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA6159B1C.9D145D7A-ON85256B48.005BBAF9@raleigh.ibm.com>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 10:44:20AM -0600 or sometime in the same epoch, Kent E Yoder scribbled:
>         Did you tweak the card's PCI config area to fix this problem, or 
> elsewhere?
> 

Kent,

Nope, the tweak was on the machine itself, something to do with the
pci bus itself. Was weird, would only show up under heavy load. Doing
multiple simulaneous ftp's of large files (ISO images) would create the 
problem, but doing a single ftp transfer of the same file wouldn't 
create the problem. 

I honestly can't remember what the exact fix was now, this was a
couple of years ago. 

-- 
Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net
mailto: mikep@linuxtr.net

