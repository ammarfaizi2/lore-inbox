Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271692AbRH0NqA>; Mon, 27 Aug 2001 09:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271719AbRH0Npu>; Mon, 27 Aug 2001 09:45:50 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:45362 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271692AbRH0Npe>; Mon, 27 Aug 2001 09:45:34 -0400
Subject: Re: Updated Linux kernel preemption patches
From: Robert Love <rml@tech9.net>
To: Cliff Albert <cliff@oisec.net>
Cc: linux-kernel@vger.kernel.org, nigel@nrg.org
In-Reply-To: <20010827093835.A15153@oisec.net>
In-Reply-To: <998877465.801.19.camel@phantasy> 
	<20010827093835.A15153@oisec.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 27 Aug 2001 09:46:12 -0400
Message-Id: <998919973.1782.65.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-08-27 at 03:38, Cliff Albert wrote:
> Kernel won't compile when this patch is applied to 2.4.8-ac12

is CONFIG_SMP set? the preempt patch and SMP are untested together.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

