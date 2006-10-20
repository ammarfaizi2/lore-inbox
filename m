Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992545AbWJTHeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992545AbWJTHeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992557AbWJTHeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:34:24 -0400
Received: from cicero1.cybercity.dk ([212.242.40.4]:36062 "EHLO
	cicero1.cybercity.dk") by vger.kernel.org with ESMTP
	id S2992545AbWJTHeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:34:22 -0400
Message-ID: <45387BF7.3010302@molgaard.org>
Date: Fri, 20 Oct 2006 09:34:15 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060717 Debian/1.7.13-0.2ubuntu1
X-Accept-Language: en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: speedstep-centrino: ENODEV
References: <EB12A50964762B4D8111D55B764A8454C1A534@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A534@scsmsx413.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
> Make sure you have properly configured speedstep-centrino (You should select X86_SPEEDSTEP_CENTRINO_ACPI along with X86_SPEEDSTEP_CENTRINO).

I have enabled all options in the make menuconfig menu under cpufreq 
(except the one marked deprecated). Still no go :-(

/sunem
