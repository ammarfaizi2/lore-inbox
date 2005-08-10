Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVHJH1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVHJH1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVHJH1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:27:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:8129 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965029AbVHJH1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:27:07 -0400
Date: Wed, 10 Aug 2005 09:27:05 +0200
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: smbus driver for ati xpress 200m
Message-ID: <20050810072705.GH19772@wotan.suse.de>
References: <42F8EB66.8020002@fujitsu-siemens.com> <86802c440508091150609eecca@mail.gmail.com> <20050809225756.GA19772@wotan.suse.de> <86802c4405080919514772d1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c4405080919514772d1c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 07:51:53PM -0700, yhlu wrote:
> yhlunb:/proc/acpi/battery/BAT1 # cat info
> present:                 yes
> design capacity:         4800 mAh
> last full capacity:      4435 mAh
> battery technology:      rechargeable
> design voltage:          14800 mV
> design capacity warning: 300 mAh
> design capacity low:     132 mAh
> capacity granularity 1:  32 mAh
> capacity granularity 2:  32 mAh
> model number:            ZF02
> serial number:           836
> battery type:            LION
> OEM info:                SIMPLO
> yhlunb:/proc/acpi/battery/BAT1 # cat state
> present:                 yes
> ERROR: Unable to read battery status

Contact the ACPI people then. They like getting their reports 
in http://bugzilla.kernel.org

-Andi
