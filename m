Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750857AbWFEJZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWFEJZb (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWFEJZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:25:30 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:30803 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750853AbWFEJZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:25:30 -0400
Date: Mon, 5 Jun 2006 02:25:28 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Marty Leisner <leisner@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: mixing cache size on xeon4's in smp system
Message-ID: <20060605092528.GA26189@tuatara.stupidest.org>
References: <200606042317.k54NHfIS026034@dell2.home> <20060604173825.A28581@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604173825.A28581@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 05:38:25PM -0600, Brian F. G. Bidulock wrote:

> For most motherboards the answer is no, regardless of whether you
> are running Linux or not.

Actually, I've had a system when the hardware was failing and one CPU
lost it's bottle and thought it had less cache (and maybe was a
different speed, forget).

Anyhow, Linux did work with the exception of timekeeping was screwy
(hence I think the speed of one CPU was wrong and I had to reboot with
notsc or something until I got the CPU replaced).

