Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbTIHJzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTIHJzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:55:20 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:40801 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262244AbTIHJzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:55:15 -0400
Date: Mon, 8 Sep 2003 10:53:59 +0100
From: Dave Jones <davej@redhat.com>
To: DervishD <raul@pleyades.net>
Cc: Ch & Ph Drapela <pcdrap@bluewin.ch>, linux-kernel@vger.kernel.org
Subject: Re: Hardware supported by the kernel
Message-ID: <20030908095357.GD10358@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	DervishD <raul@pleyades.net>, Ch & Ph Drapela <pcdrap@bluewin.ch>,
	linux-kernel@vger.kernel.org
References: <3F59DF81.8000407@bluewin.ch> <20030906134029.GE69@DervishD> <20030907223258.GE28927@redhat.com> <20030908092952.GA51@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908092952.GA51@DervishD>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 11:29:52AM +0200, DervishD wrote:
 > >  > > - an ATI Gapiccard
 > >  >     I have an ATI card (128 LT Pro) and it's fully supported. IMHO
 > >  > all ATI cards are.
 > > Depends on your definition of 'supported'. Recent ATI cards[*] will
 > > only work in accelerated 3d using their binary only driver.
 > 
 >     A couple of months ago someone on this list said that ATI no
 > longer provides information about their graphics cards, so when I say
 > 'supported' I'm speaking of my particular model, that it's really
 > supported (is a quite old model). When I said 'all ATI cards' I was
 > talking about older models, because I forgot that ATI no longer
 > supports Linux.
 > 
 >     My mistake, sorry. BTW: what graphics cards manufacturer currently
 > supports Linux?. I need to buy a new graphic card for a friend (AGP)
 > and I don't know what one to buy :(((

in the performance/gamer end of the market, you're screwed.

ATI -    Radeon 9200 is AGPx8, supported by open driver (Based on R200 core)
         All other current cards need binary only driver.
Nvidia - Binary only for accelerated 3d.
Matrox - Not exactly a speed demon any more in the 3d market. Open
         drivers though. Not sure about Parhelia.
SiS    - Cards like the Xabre are quite cheap, though unsupported,
         though SiS folks did seemto wnat to help at one point, then
         when quiet.
S3     - Again, poorly performing, specs/drivers are out there.


who did I miss ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
