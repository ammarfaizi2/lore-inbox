Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbRETOQ4>; Sun, 20 May 2001 10:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261977AbRETOQq>; Sun, 20 May 2001 10:16:46 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:32777 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S261976AbRETOQb>; Sun, 20 May 2001 10:16:31 -0400
Date: Mon, 21 May 2001 02:16:19 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010521021619.A6946@metastasis.f00f.org>
In-Reply-To: <811opRpHw-B@khms.westfalen.de> <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com> <p05100316b7272cdfd50c@[207.213.214.37]> <811opRpHw-B@khms.westfalen.de> <p05100301b72a335d4b61@[10.128.7.49]> <81BywVLHw-B@khms.westfalen.de> <p0510031eb72c5f11b8c7@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p0510031eb72c5f11b8c7@[207.213.214.37]>; from jlundell@pobox.com on Sat, May 19, 2001 at 10:36:14AM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 10:36:14AM -0700, Jonathan Lundell wrote:

    I know from system documentation, or can figure out once and for
    all by experimentation, the correspondence between PCI
    bus/dev/fcn and physical locations. Jeff's extension gives me the
    mapping between eth# and PCI bus/dev/fcn, which is not otherwise
    available (outside the kernel).

Won't work with hotplug PCI (consider plugging in something with a
bridge).



  --cw
