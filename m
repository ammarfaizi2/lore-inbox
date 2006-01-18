Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWARWxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWARWxa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWARWxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:53:11 -0500
Received: from [63.81.120.158] ([63.81.120.158]:51182 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S932586AbWARWxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:53:09 -0500
Date: Wed, 18 Jan 2006 15:06:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: "Mark A. Greer" <mgreer@mvista.com>, Jean Delvare <khali@linux-fr.org>,
       adi@hexapodia.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] i2c: Combined ST m41txx i2c rtc chip driver
Message-ID: <20060118220600.GF15714@mag.az.mvista.com>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <20051116025714.GK5546@mag.az.mvista.com> <20051219210325.GA21696@mag.az.mvista.com> <43A7D76E.5050008@varma-el.com> <20060111000912.GA11471@mag.az.mvista.com> <43C4D275.2070505@varma-el.com> <20060111161954.GB6405@mag.az.mvista.com> <43C5567C.8070106@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C5567C.8070106@varma-el.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 10:03:24PM +0300, Andrey Volkov wrote:
<snip>
> P.S. Jean, "i2c_master_send vs i2c_smbus_write_byte_data"
> problem still open.
> Could you made executive decision about it?

Hi Andrey,

I'm taking the roaring silence to mean nobody really cares so I don't
really have a problem going your way.  I'll submit a patch and if it
gets pooh-pooh'd, we can always change it back.

Stay tuned.

Mark
