Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129950AbQLEXVl>; Tue, 5 Dec 2000 18:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129912AbQLEXVa>; Tue, 5 Dec 2000 18:21:30 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:48900
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129909AbQLEXV0>; Tue, 5 Dec 2000 18:21:26 -0500
Date: Wed, 6 Dec 2000 11:50:57 +1300
From: Chris Wedgwood <cw@f00f.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: John Meikle <linux@procom.demon.co.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Using map_user_kiobuf()
Message-ID: <20001206115057.A5341@metastasis.f00f.org>
In-Reply-To: <20001206030850.A4661@metastasis.f00f.org> <200012052007.eB5K7RK436972@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012052007.eB5K7RK436972@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Dec 05, 2000 at 03:07:26PM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, this is better



   --cw


On Tue, Dec 05, 2000 at 03:07:26PM -0500, Albert D. Cahalan wrote:
    >     Am I the only one who finds the READ/WRITE option back to front?
    >     
    > No, I was just thinking it should be change to USER_READ, USER_WRITE
    > or something a little more obvious. 
    
    Eh, read data from userspace and write data to userspace? Oops.
    
    FROM_USER
    TO_USER
    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
