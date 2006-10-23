Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWJWW3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWJWW3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWJWW3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:29:09 -0400
Received: from gw.goop.org ([64.81.55.164]:49041 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932259AbWJWW3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:29:06 -0400
Message-ID: <453D4230.8020505@goop.org>
Date: Mon, 23 Oct 2006 15:29:04 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Avi Kivity <avi@qumranet.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <200610221723.48646.arnd@arndb.de>	<453B99D7.1050004@qumranet.com> <200610221851.06530.arnd@arndb.de>	<453BA3E9.4050907@qumranet.com> <20061022175609.GA28152@infradead.org>	<453BB1B0.7040500@qumranet.com> <p73ac3om1g7.fsf@verdi.suse.de>
In-Reply-To: <p73ac3om1g7.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Why? AFAIK there are no VT machines that don't support EM64T.
>   
Core Duo has VT but no 64-bit.

    J
