Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbRE3XGI>; Wed, 30 May 2001 19:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbRE3XF6>; Wed, 30 May 2001 19:05:58 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:2565 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262885AbRE3XFo>;
	Wed, 30 May 2001 19:05:44 -0400
Date: Wed, 30 May 2001 19:07:44 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Cc: bjorn.wesen@axis.com, trini@kernel.crashing.org
Subject: Only 5 undocumented configuration symbols left
Message-ID: <20010530190744.A2027@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net, bjorn.wesen@axis.com,
	trini@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current list of symbols with missing help is very short. Here it is:

PPC port:

CONFIG_BLK_DEV_MPC8xx_IDE
CONFIG_IRQ_ALL_CPUS
CONFIG_USE_MDIO

CRIS port:

CONFIG_ETRAX_FLASH_BUSWIDTH
CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C

Let's finish this off, people!
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The people cannot delegate to government the power to do anything
which would be unlawful for them to do themselves.
	-- John Locke, "A Treatise Concerning Civil Government"
