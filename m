Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132125AbRDFRe5>; Fri, 6 Apr 2001 13:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbRDFRer>; Fri, 6 Apr 2001 13:34:47 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52117 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132125AbRDFReg>;
	Fri, 6 Apr 2001 13:34:36 -0400
Message-ID: <3ACDFE03.1CC074E3@mandrakesoft.com>
Date: Fri, 06 Apr 2001 13:33:55 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernhard Bender <Bernhard.Bender@ELSA.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ethernet phy link state info
In-Reply-To: <41256A26.005733A6.00@elsa.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Bender wrote:
> where do I find information about the current link state of the ethernet PHY
> (e.g. 100mbit/s full duplex) ?
> Something like /proc/sys/net/* ?

/sbin/mii-tool

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
