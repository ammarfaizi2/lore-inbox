Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292586AbSB0QDv>; Wed, 27 Feb 2002 11:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292511AbSB0QDl>; Wed, 27 Feb 2002 11:03:41 -0500
Received: from brev.stud.ntnu.no ([129.241.56.70]:32430 "EHLO
	brev.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S292593AbSB0QDX>; Wed, 27 Feb 2002 11:03:23 -0500
Date: Wed, 27 Feb 2002 17:03:21 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020227170321.B22422@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020227125611.A20415@stud.ntnu.no> <20020227.040653.58455636.davem@redhat.com> <20020227132454.B24996@stud.ntnu.no> <20020227.042845.54186884.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227.042845.54186884.davem@redhat.com>; from davem@redhat.com on Wed, Feb 27, 2002 at 04:28:45AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> At this point I'm mostly interested in if it works at all :-)
> If the answer is yes, tell me that and then you can feel
> free to experiment with jumbo frames et al. to discover
> other bugs in the driver :-)

Just tested with MTU set at 1500 for now, but it seems to work fine, did a
netcat between two boxes on the same switch and got around 80MB/sec.

Any programs or anything that could do a serious stresstest?  (Both hosts
are Dell PowerEdge 2550, RedHat Linux 7.2).

-- 
Thomas
