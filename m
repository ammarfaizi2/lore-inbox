Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbUKPPw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUKPPw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 10:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUKPPw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 10:52:59 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:32028 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262005AbUKPPw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 10:52:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=sq2X0klM/mlF4O+mXq/bKeCta0UMs6+MYPpFQsmKB4ZtUyd6G8OEvNHB77MAfDG1cqF7z6QVIozg8csWwSSlWMI8qAJzyiPVyYIZwfgWbYtUsrbHE33Vny0FGP2jtMIGHlj5lFhdkRO+SL3VESsdF8nFrueqb+/LVK32TPKIEWk=
Message-ID: <e796392204111607521606f684@mail.gmail.com>
Date: Tue, 16 Nov 2004 16:52:56 +0100
From: Stefan Schweizer <sschweizer@gmail.com>
Reply-To: Stefan Schweizer <sschweizer@gmail.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041116162924.2ee20f4d@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041027001542.GA29295@elte.hu> <20041109160544.GA28242@elte.hu>
	 <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu>
	 <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu>
	 <20041116134027.GA13360@elte.hu>
	 <20041116152021.79409166@mango.fruits.de>
	 <20041116160822.6a845755@mango.fruits.de>
	 <20041116162924.2ee20f4d@mango.fruits.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 16:29:24 +0100, Florian Schmidt <mista.tapas@gmx.net> wrote:
> ok, this new build still hangs at the same spot.

same problem here
