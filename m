Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbTGCWfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265450AbTGCWfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:35:06 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5138 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265431AbTGCWfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:35:04 -0400
Date: Fri, 4 Jul 2003 00:49:28 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Message-ID: <20030703224928.GB20143@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <00d901c340a8$810556c0$3300a8c0@Slepetys> <1083830000.1057158848@aslan.scsiguy.com> <01b101c340dc$ede386c0$3300a8c0@Slepetys> <016901c34191$14c4a1c0$3300a8c0@Slepetys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016901c34191$14c4a1c0$3300a8c0@Slepetys>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jul 2003, Roberto Slepetys Ferreira wrote:

> Meanning that the Load Average is incompatible with the use of the CPUs.

To find the stuck process that pushes your LA up, try: ps ax | grep -w D
