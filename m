Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130375AbRAEJY3>; Fri, 5 Jan 2001 04:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRAEJYT>; Fri, 5 Jan 2001 04:24:19 -0500
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:55520 "EHLO
	mailgate1.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S130375AbRAEJYB>; Fri, 5 Jan 2001 04:24:01 -0500
Date: Fri, 5 Jan 2001 10:23:56 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: "Michael D . Crawford" <crawford@goingware.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
Message-ID: <20010105102356.B17200@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	"J . A . Magallon" <jamagallon@able.es>,
	"Michael D . Crawford" <crawford@goingware.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A55403C.39E4A48B@goingware.com> <20010105101846.A2095@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
In-Reply-To: <20010105101846.A2095@werewolf.able.es>; from jamagallon@able.es on Fri, Jan 05, 2001 at 10:18:46AM +0100
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 10:18:46AM +0100, J . A . Magallon wrote:
> 
> Silly question, but have you realized that you don't have to enable
> SMP in kernel to do multithreading ?
> 

That depends on your definition: If you really want to run multiple
threads simultaneously (as opposed to concurrent i guess) i imagine
you will either need more than one CPU or one of those new beasties
which support multiple threads in parallel on their various execution
units...

Dominik
-- 
http://petition.eurolinux.org/index_html - No Software Patents In Europe!
http://petition.lugs.ch/ (in Switzerland)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
