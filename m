Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbTC0UV1>; Thu, 27 Mar 2003 15:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbTC0UV1>; Thu, 27 Mar 2003 15:21:27 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:7817 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S261326AbTC0UV0>;
	Thu, 27 Mar 2003 15:21:26 -0500
Message-ID: <3E835FEE.3050809@portrix.net>
Date: Thu, 27 Mar 2003 21:32:46 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <20030327194248.GK32667@kroah.com>
In-Reply-To: <20030327194248.GK32667@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> fan_min[1-3]	Fan minimum value
> in_min[0-8]	Voltage min value.
> pwn[1-3]	Pulse width modulation fan control.
> temp_input[1-3] Temperature input value.
Why not start all these counts from 0? Is there any reason to start from 
1? Historical reasons or does the datasheet start the counting from 1?

Jan

