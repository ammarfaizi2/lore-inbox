Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132054AbRECPiA>; Thu, 3 May 2001 11:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRECPhu>; Thu, 3 May 2001 11:37:50 -0400
Received: from pcow029o.blueyonder.co.uk ([195.188.53.123]:14346 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S131479AbRECPhg>;
	Thu, 3 May 2001 11:37:36 -0400
From: Eric Barton <eric@bartonsoftware.com>
To: linux-kernel@vger.kernel.org
Subject: make_pages_present()
Message-ID: <01a473339150351PCOW029M@blueyonder.co.uk>
Date: 3 May 2001 16:39:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can someone tell me if make_pages_present() is always called with
a page aligned address?  If not, it may not make the last page present...

-- 

                Cheers,
                        Eric

----------------------------------------------------
|Eric Barton        Barton Software                |
|9 York Gardens     Tel:    +44 (117) 923 9831     |
|Clifton            Mobile: +44 (7909) 680 356     |
|Bristol BS8 4LL    Fax:    call first             |
|United Kingdom     E-Mail: eric@bartonsoftware.com|
----------------------------------------------------

