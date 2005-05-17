Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVEQRin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVEQRin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEQRf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:35:59 -0400
Received: from dvhart.com ([64.146.134.43]:14754 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261895AbVEQRel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:34:41 -0400
Date: Tue, 17 May 2005 10:34:37 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
Message-ID: <844780000.1116351277@flay>
In-Reply-To: <Pine.LNX.4.62.0505171020130.10798@graphe.net>
References: <734820000.1116277209@flay> <Pine.LNX.4.62.0505161602460.20110@graphe.net><826450000.1116349699@flay> <828790000.1116349787@flay> <Pine.LNX.4.62.0505171020130.10798@graphe.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, May 17, 2005 10:20:49 -0700 Christoph Lameter <christoph@lameter.com> wrote:

> On Tue, 17 May 2005, Martin J. Bligh wrote:
> 
>> > Nope. same failure.
>> 
>> Oops. I lie. Now it gets the other failure (the panic on boot we were
>> discussing before). So yes, that patch worked.
> 
> You removed the slab patches right? So this confirms that the panic on 
> boot has nothing to do with the numa slab allocator?

Nope, not yet. I just applied your other patch.

M.

