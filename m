Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265158AbRFUTqO>; Thu, 21 Jun 2001 15:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265163AbRFUTqC>; Thu, 21 Jun 2001 15:46:02 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:8466 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265158AbRFUTpu>;
	Thu, 21 Jun 2001 15:45:50 -0400
Date: Thu, 21 Jun 2001 15:49:34 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Missing help entries in 2.4.6pre5
Message-ID: <20010621154934.A6582@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following configuration symbols in 2.4.6pre5 do not have 
Congfgure.help entries,:

CONFIG_ACPI_AC
CONFIG_ACPI_BUSMGR
CONFIG_ACPI_BUTTON
CONFIG_ACPI_CMBATT
CONFIG_ACPI_CPU
CONFIG_ACPI_DEBUG
CONFIG_ACPI_EC
CONFIG_ACPI_SYS
CONFIG_ACPI_THERMAL
CONFIG_MOMENCO_OCELOT
CONFIG_MTD_CFI_VIRTUAL_ER
CONFIG_XSCALE_IQ80310

Would the responsible parties please send me doocumentation for the 
Configure.help masters?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Before a standing army can rule, the people must be disarmed, as they
are in almost every kingdom in Europe. The supreme power in America
cannot enforce unjust laws by the sword, because the people are armed,
and constitute a force superior to any band of regular troops.
	-- Noah Webster
