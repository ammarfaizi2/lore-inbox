Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132530AbRDBGbB>; Mon, 2 Apr 2001 02:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRDBGav>; Mon, 2 Apr 2001 02:30:51 -0400
Received: from hibernia.clubi.ie ([212.17.32.129]:62853 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S132530AbRDBGam>; Mon, 2 Apr 2001 02:30:42 -0400
Date: Mon, 2 Apr 2001 07:30:34 +0100 (IST)
From: Paul Jakma <paul@jakma.org>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: "Trever L. Adams" <trever_Adams@bigfoot.com>,
   Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
   linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial, 115Kbps, 2.2, 2.4
In-Reply-To: <003001c0bb0e$100149b0$08080808@zeusinc.com>
Message-ID: <Pine.LNX.4.33.0104020729010.23387-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Tom Sightler wrote:

> III) I get a fair number of dropped packets at 115Kbps, enough to cause
> problems and a significant speed decrease.  Simply dropping the serial port
> rate to 56K seems to solve the problem.

does the system have IDE disks? (DEC Venturis GL.. should be)

Try hdparm -u on all your IDE disks... should improve things.

> Later,
> Tom

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
What I want is all of the power and none of the responsibility.


