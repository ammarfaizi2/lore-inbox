Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUAHThf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266264AbUAHThc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:37:32 -0500
Received: from smtp13.eresmas.com ([62.81.235.113]:58059 "EHLO
	smtp13.eresmas.com") by vger.kernel.org with ESMTP id S266263AbUAHTgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:36:20 -0500
Message-ID: <3FFDB0EC.90504@wanadoo.es>
Date: Thu, 08 Jan 2004 20:35:08 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: What driver for NetXtreme?
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:

> I just ordered an eval of a IBM server.  This server is supposed to
> have a Dual-Port NetXtreme Gigabit network card.  Anyone have any idea
> what drivers I'm going to need for this sucker?

it's a broadcom NIC. The driver is tg3



