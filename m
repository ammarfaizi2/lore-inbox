Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRCARHT>; Thu, 1 Mar 2001 12:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129723AbRCARHG>; Thu, 1 Mar 2001 12:07:06 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:48389 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129624AbRCARG6>;
	Thu, 1 Mar 2001 12:06:58 -0500
To: Ofer Fryman <ofer@shunra.co.il>
Cc: "'kernel@kvack.org'" <kernel@kvack.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Intel-e1000 for Linux 2.0.36-pre14
In-Reply-To: <F1629832DE36D411858F00C04F24847A11DECF@SALVADOR>
From: Jes Sorensen <jes@linuxcare.com>
Date: 01 Mar 2001 18:06:42 +0100
In-Reply-To: Ofer Fryman's message of "Thu, 1 Mar 2001 17:51:30 +0200"
Message-ID: <d3elwhwh99.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ofer" == Ofer Fryman <ofer@shunra.co.il> writes:

Ofer> I need a giga fiber PMC cards for linux2.0.36-pre14, the only
Ofer> cards I know are either Intel based or level-one lxt-1001 card,
Ofer> the level-one lxt-1001 has very bad performance so I cannot use
Ofer> it.

I'd recommend you to upgrade to at least 2.2.x, the scalability of
2.0.x means there is really no good reason to spend time porting GigE
drivers to it.

Jes
