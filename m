Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135718AbRDXTFG>; Tue, 24 Apr 2001 15:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135720AbRDXTE4>; Tue, 24 Apr 2001 15:04:56 -0400
Received: from [213.97.199.90] ([213.97.199.90]:3456 "HELO roku.redroom.com")
	by vger.kernel.org with SMTP id <S135718AbRDXTEr> convert rfc822-to-8bit;
	Tue, 24 Apr 2001 15:04:47 -0400
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Tue, 24 Apr 2001 21:03:13 +0200 (CEST)
To: Tomas Telensky <ttel5535@ss1000.ms.mff.cuni.cz>
cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.21.0104241508370.11387-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0104242054210.2397-100000@roku.redroom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001, Tomas Telensky wrote:

> 
> But, what I should say to the network security, is that AFAIK in the most
> of linux distributions the standard daemons (httpd, sendmail) are run as
> root! Having multi-user system or not! Why? For only listening to a port
> <1024? Is there any elegant solution?
> 

httpd as root ? that's what i call a clueless network admin.
sendmail has an OBSOLETE design. Use a good MTA like qmail. Exim or
smail are ok, but they're still "sendmailish".


David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


