Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVDSIEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVDSIEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDSIEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:04:43 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:7564 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261388AbVDSIEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:04:30 -0400
Date: Tue, 19 Apr 2005 10:04:24 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :(
Message-ID: <20050419080424.GA28153@mail.muni.cz>
References: <20050414214828.GB9591@mail.muni.cz> <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz> <4264B202.9080304@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4264B202.9080304@univ-nantes.fr>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 09:23:46AM +0200, Yann Dupont wrote:
> Do you have turned NAPI on ??? I tried without it off on e1000 and ...
> surprise !
> Don't have any messages since 12H now (usually I got those in less than 1H)

I have NAPI on. I tried to turn it off but my test failed, I can see allocation
failure again.

-- 
Luká¹ Hejtmánek
