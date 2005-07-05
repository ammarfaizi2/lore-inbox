Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVGEMJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVGEMJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 08:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVGEMJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 08:09:40 -0400
Received: from gate.in-addr.de ([212.8.193.158]:45218 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261816AbVGEMGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 08:06:31 -0400
Date: Tue, 5 Jul 2005 14:06:21 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Richard B. Johnson" <linux-os@analogic.com>,
       Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A "new driver model" and EXPORT_SYMBOL_GPL question
Message-ID: <20050705120621.GM2879@marowsky-bree.de>
References: <20050703171202.A7210@mail.harddata.com> <Pine.LNX.4.61.0507050703220.20388@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0507050703220.20388@chaos.analogic.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-07-05T07:09:47, "Richard B. Johnson" <linux-os@analogic.com> wrote:

> This problem will continue. Eventually there will be no general
> exported symbols. The apparent idea is to prevent the use of the
> kernel in proprietary systems.

... with proprietary kernel extensions. There's a difference.

> Not to worry. The tools provided with a typical Linux distribution
> are capable of resolving those symbols. You can make a script
> that `greps`  System.map for the correct offsets of those symbols.
> You can use those offsets in a linker script.

If it wasn't you, I'd be assuming you'd be joking when suggesting to
subvert the clear wishes of and licensing granted by the copyright
holders and authors.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

